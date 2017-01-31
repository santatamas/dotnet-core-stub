var target = Argument("target", "Default");
var tag = Argument("tag", "local");

Task("Restore")
  .Does(() =>
{
	 var settings = new DotNetCoreRestoreSettings
     {
         PackagesDirectory = "package_cache"
     };
    DotNetCoreRestore("src", settings);
});

Task("Build")
  .IsDependentOn("Restore")
  .Does(() =>
{
    DotNetCoreBuild("src/**/project.json");
});

Task("Test")
  .Does(() =>
{
    var files = GetFiles("src/*.Tests/project.json");
    foreach(var file in files)
    {
        var settings = new DotNetCoreTestSettings
        {
            WorkingDirectory = "report/junit"
        };
        DotNetCoreTest(file.ToString(), settings);
    }
});

Task("Publish")
    .Does(() =>
{
    var publishTargets = new string[]{"src/Web", "src/Api"};
    foreach(var pt in publishTargets)
    {
        var settings = new DotNetCorePublishSettings
        {
            Framework = "netcoreapp1.1",
            Configuration = "Release",
            OutputDirectory = pt + "/publish/",
            VersionSuffix = tag
        };

    DotNetCorePublish(pt, settings);
    }
});

Task("Default")
    .IsDependentOn("Test");

RunTarget(target);