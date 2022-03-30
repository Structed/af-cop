# af-cop
af-cop (Azure Functions - Change of Plans!) is a small PowerShell script to swap your App Service Plans.

Use it to swap your Azure Functions Plan from Consumption Plan to Premium and vice versa!
When switching to premium, it will create a Premium Plan.
If you switch back to consumption plan, it will delete the Premium Plan, so you don't have to pay for it.

Check out the parameter documentation for more info!


# Warning/Disclaimer
The usage of this script is at your own peril. Neitehr myself nor my emplyoer will take any liability on what you do with it!
Please be advised that by using this script, you can **break** your Function App!

* Premium Plan has a constant cost, depending on the Plan you choose
* premium Plan has some additional features over Consumption Plan. If you intend to go back to Consumption plan, do nto use featrues like VNETs which would break on a Consumption Plan!


# Examples:

## Comsumption ➡ Premium Plan:
> Note: `-Sku EP2` will use a `EP2` Plan. Defaults to `EP1`

    .\af-cop.ps1 -resourceGroup function-app-rg -consumptionPlanName ASP-consumption -premiumPlanName ASP-premium -functionAppName function-swap-app -toPremium $true -Sku EP2
    
## Premium Plan ➡ Comsumption:
    .\af-cop.ps1 -resourceGroup function-app-rg -consumptionPlanName ASP-consumption -premiumPlanName ASP-premium -functionAppName function-swap-app -toPremium $false

# Thanks
Many thanks to [Stefano Demiliani](https://twitter.com/demiliani), on whose [blog-post](https://demiliani.com/2020/12/02/moving-azure-functions-from-consumption-to-premium-plans/) this script is based on!
