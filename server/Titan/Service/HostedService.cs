using Titan.Domain.Constant;
using Titan.Domain.DTO.Execution;
using Titan.Domain.Interface.Service;
using Titan.Domain.Mapper;
using Titan.Domain.Util;

namespace Titan.Service
{
    public class HostedService : BackgroundService
    {
        private readonly IServiceProvider _serviceProvider;
        private readonly ILogger<HostedService> _logger;
        private DateTime currentDate { get { return DateTime.UtcNow.ToLocalTime(); } }

        public HostedService(ILogger<HostedService> logger, IServiceProvider serviceProvider)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
        }

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            _logger.LogInformation($"{currentDate} - Hosted Service is working.");
            while (!stoppingToken.IsCancellationRequested)
            {
                await Task.Delay(60 * 1000); // 60 seconds
                try
                {
                    using var scope = _serviceProvider.CreateScope();
                    var executionService = scope.ServiceProvider.GetRequiredService<IExecutionService>();
                    var eventService = scope.ServiceProvider.GetRequiredService<IEventService>();

                    await RunEvents(eventService, executionService);
                }
                catch (Exception ex)
                {
                    _logger.LogInformation($"{currentDate} - Hosted Service Error: {ex}");
                }
            }
        }

        private async Task RunEvents(IEventService eventService, IExecutionService executionService)
        {
            var events = await eventService.Get();
            if (events == null)
            {
                return;
            }
            foreach (var itemEvent in events)
            {
                var request = new ExecutionRequestDTO
                {
                    EventId = itemEvent.Id
                };
                var execution = await executionService.Create(request);
                if (execution == null)
                {
                    continue;
                }

                var requestUpdateStep = new ExecutionUpdateStepDTO
                {
                    Id = execution.Id,
                    Step = ExecutionStepConstant.Success
                };

                var clientEvent = new HttpClient(HttpUtil.CreateHandleIgnoreSssl());
                var methodRequest = MethodMapper.ConvertConstantToHttp(itemEvent.Method);
                var requestMessage = new HttpRequestMessage(methodRequest, itemEvent.Url);
                var responseClientEvent = await clientEvent.SendAsync(requestMessage);
                if (!responseClientEvent.IsSuccessStatusCode)
                {
                    requestUpdateStep.Step = ExecutionStepConstant.Fail;
                }

                await executionService.UpdateStep(requestUpdateStep);
            }
        }

    }
}
