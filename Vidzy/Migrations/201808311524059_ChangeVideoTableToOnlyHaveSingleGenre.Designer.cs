// <auto-generated />
namespace Vidzy.Migrations
{
    using System.CodeDom.Compiler;
    using System.Data.Entity.Migrations;
    using System.Data.Entity.Migrations.Infrastructure;
    using System.Resources;
    
    [GeneratedCode("EntityFramework.Migrations", "6.2.0-61023")]
    public sealed partial class ChangeVideoTableToOnlyHaveSingleGenre : IMigrationMetadata
    {
        private readonly ResourceManager Resources = new ResourceManager(typeof(ChangeVideoTableToOnlyHaveSingleGenre));
        
        string IMigrationMetadata.Id
        {
            get { return "201808311524059_ChangeVideoTableToOnlyHaveSingleGenre"; }
        }
        
        string IMigrationMetadata.Source
        {
            get { return null; }
        }
        
        string IMigrationMetadata.Target
        {
            get { return Resources.GetString("Target"); }
        }
    }
}