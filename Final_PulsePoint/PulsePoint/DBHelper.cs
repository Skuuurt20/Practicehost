using System.Configuration;

namespace Pulsepoint
{
    public static class DBHelper
    {
        // Returns the connection string from the web.config
        public static string ConnectionString
        {
            get
            {
                return ConfigurationManager.ConnectionStrings["PulsePointConnectionString"].ConnectionString;
            }
        }

        // You can add additional shared database functions here if needed.
    }
}
