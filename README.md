# af-cop
af-cop (Azure Functions - Change of Plans!) is a small PowerShell script to swap your App Service Plans.

Use it to swap your Azure Functions Plan from Consumption Plan to Premium and vice versa!
When switching to premium, it will create a Premium Plan.
If you switch back to consumption plan, it will delete the Premium Plan, so you don't have to pay for it.

> Please be advised: Premium Plan has a constant cost!

Check out the parameter documentation for more info!


# Examples:

## Comsumption ➡ Premium Plan:
> Note: `-Sku EP2` will use a `EP2` Plan. Defaults to `EP1`

    .\af-cop.ps1 -resourceGroup function-app-rg -consumptionPlanName ASP-consumption -premiumPlanName ASP-premium -functionAppName function-swap-app -toPremium $true -Sku EP2
    
## Premium Plan ➡ Comsumption:
    .\af-cop.ps1 -resourceGroup function-app-rg -consumptionPlanName ASP-consumption -premiumPlanName ASP-premium -functionAppName function-swap-app -toPremium $false
