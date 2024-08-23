using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;
using Titan.Domain.RegularExpression;

namespace Titan.Domain.DTO.Event
{
    public class EventUpdateRequestDTO
    {
        [JsonIgnore]
        public Guid Id { get; set; }
        [Required]
        public string Name { get; set; } = null!;

        [Required]
        public string Url { get; set; } = null!;

        [Required]
        [RegularExpression(RequestMethodRegularExpression.Expression)]
        public string Method { get; set; } = null!;

        public int Interval { get; set; }
    }
}
