using Titan.Domain.Constant;

namespace Titan.Domain.Mapper
{
    public static class MethodMapper
    {
        public static HttpMethod ConvertConstantToHttp(string value)
        {
            switch (value)
            {
                case RequestMethodConstant.Get:
                    return HttpMethod.Get;
                case RequestMethodConstant.Post:
                    return HttpMethod.Post;
                case RequestMethodConstant.Put:
                    return HttpMethod.Put;
                case RequestMethodConstant.Patch:
                    return HttpMethod.Patch;
                case RequestMethodConstant.Delete:
                    return HttpMethod.Delete;
                default:
                    throw new NotImplementedException();
            }
        }
    }
}
