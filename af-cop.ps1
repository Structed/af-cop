# af-cop by Johannes Ebner
# Licensed under MIT License
# https://github.com/Structed/af-cop

[CmdletBinding(
    SupportsShouldProcess,
    ConfirmImpact = 'High'
)]
param(
    # The resource group of the Function & Plans
    [Parameter(Mandatory = $true)]
    [string]
    $ResourceGroup,

    # The Function App's name to update with the plan
    [Parameter(Mandatory = $true)]
    [string]
    $FunctionAppName,

    # The Consumption Plan's name
    [Parameter(Mandatory = $true)]
    [string]
    $ConsumptionPlanName,

    # The Premium Plan's name
    [Parameter(Mandatory = $true)]
    [string]
    $PremiumPlanName,

    # Whether the switch should be towards the premium tier. If $false, will return back to the consumption plan!
    [bool]
    [Parameter(Mandatory = $true)]
    $ToPremium,

    # If $true, will force the operation.
    # WARNING: Only use if you are not using any specific premium features, like VNets!
    [bool]
    $Force = $false,

    # Which SKU to use. Defaults to EP1. See https://docs.microsoft.com/en-us/azure/azure-functions/functions-premium-plan?tabs=portal#available-instance-skus
    [string]
    [ValidateSet("EP1", "EP2", "EP3")]
    $Sku = "EP1"
)

# Implement Force - if this is not there, you would need to call with -Confirm:$false
if ($Force){
    $ConfirmPreference = 'None'
}


if ($ToPremium) {
    if($PSCmdlet.ShouldProcess($ResourceGroup, "Create premium plan '$PremiumPlanName'")){
        # Create new Premium Plan
        az functionapp plan create --name $PremiumPlanName --sku $Sku --resource-group $ResourceGroup --location 'West Europe'
    }
    if($PSCmdlet.ShouldProcess($FunctionAppName, "Switch from consumption plan '$ConsumptionPlanName' to premium plan '$PremiumPlanName'")){
        # Switch to Premium Plan
        az functionapp update --name $FunctionAppName --resource-group $ResourceGroup --plan $PremiumPlanName
    }
} else {
    if($PSCmdlet.ShouldProcess($FunctionAppName, "Switch from to premium plan '$PremiumPlanName' consumption plan '$ConsumptionPlanName'")){
        # Switch back to Consumption Plan. WARNING: Only use if you are not using any specific premium features, like VNets!
        az functionapp update --name $FunctionAppName --resource-group $ResourceGroup --plan $ConsumptionPlanName --force
    }

    if($PSCmdlet.ShouldProcess($PremiumPlanName, "DELETE premium plan")){
        # Delete the Premium Plan, once you no longer need it
        az functionapp plan delete --resource-group $ResourceGroup --name $PremiumPlanName
    }
}
