using System.ComponentModel.DataAnnotations;
using Titan.Domain.RegularExpression;

namespace Titan.Domain.DTO.Execution
{
    public class ExecutionUpdateStepDTO
    {
        public Guid Id { get; set; }

        [RegularExpression(StepExecutionRegularExpression.Expression)]
        public string Step { get; set; } = null!;
    }
}
