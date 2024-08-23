namespace Titan.Domain.Util
{
    public static class HttpUtil
    {
        public static HttpClientHandler CreateHandleIgnoreSssl()
        {
            return new HttpClientHandler
            {
                ClientCertificateOptions = ClientCertificateOption.Manual,
                ServerCertificateCustomValidationCallback = (_, _, _, _) =>
                {
                    return true;
                }
            };
        }
    }
}
