param(
    [ValidateSet("1k", "2k")]
    [string]$Resolution = "2k",
    [string]$Destination = ".\backgrounds"
)

$ErrorActionPreference = "Stop"

$assets = @(
    "vintage_measuring_lab", "machine_shop_01", "machine_shop_02", "machine_shop_03",
    "industrial_workshop_foundry", "autoshop_01", "aerodynamics_workshop",
    "university_workshop", "boiler_room", "industrial_pipe_and_valve_01",
    "industrial_pipe_and_valve_02", "empty_warehouse_01", "auto_service",
    "aircraft_workshop_01", "garage", "workshop", "small_workshop", "small_hangar_01",
    "small_hangar_02", "hangar_interior", "peppermint_powerplant",
    "peppermint_powerplant_2", "old_bus_depot", "abandoned_workshop",
    "abandoned_workshop_02", "abandoned_factory_canteen_01",
    "abandoned_factory_canteen_02", "abandoned_greenhouse", "old_depot",
    "abandoned_garage", "carpentry_shop_01", "carpentry_shop_02", "empty_workshop",
    "abandoned_construction", "abandoned_bakery", "school_quad", "newman_lobby",
    "events_hall_interior", "yoga_room", "climbing_gym", "school_hall",
    "newman_cafeteria", "debris_basement_corridor", "bank_vault",
    "rostock_laage_airport", "large_corridor", "concrete_tunnel", "concrete_tunnel_02",
    "short_tunnel", "birbeck_street_underpass", "subway_entrance", "metro_vijzelgracht",
    "squash_court", "crossfit_gym", "gym_entrance", "gym_01", "kart_club",
    "billiard_hall", "empty_play_room", "unfinished_office", "unfinished_office_night",
    "small_empty_room_1", "small_empty_room_2", "small_empty_room_4", "entrance_hall",
    "overcast_industrial_courtyard", "stadium_exterior", "abandoned_parking",
    "driving_school", "mall_parking_lot", "suburban_parking_area", "learner_park",
    "skidpan", "zwartkops_pit", "zwartkops_straight_morning", "wide_street_01",
    "wide_street_02", "urban_street_01", "urban_street_02", "urban_street_03",
    "urban_street_04", "urban_alley_01", "urban_courtyard_02", "pretville_street",
    "hanger_exterior_cloudy", "derelict_underpass", "derelict_overpass",
    "teufelsberg_roof", "quadrangle_cloudy", "quadrangle_sunny", "blocky_photo_studio",
    "photo_studio_01", "studio_small_01", "studio_small_02", "studio_small_04",
    "studio_small_05", "studio_small_06", "cyclorama_hard_light", "pav_studio_01",
    "monochrome_studio_01"
)

$destinationPath = [System.IO.Path]::GetFullPath($Destination)
New-Item -ItemType Directory -Force -Path $destinationPath | Out-Null

Write-Host "Hedef klasor : $destinationPath"
Write-Host "Cozunurluk   : $Resolution EXR"
Write-Host "Dosya sayisi : $($assets.Count)"

$completed = 0
$skipped = 0
$failed = @()

foreach ($asset in $assets) {
    $fileName = "${asset}_${Resolution}.exr"
    $target = Join-Path $destinationPath $fileName
    $temporary = "$target.part"
    $url = "https://dl.polyhaven.org/file/ph-assets/HDRIs/exr/$Resolution/$fileName"

    if (Test-Path $target) {
        Write-Host "[ATLANDI] $fileName"
        $skipped++
        continue
    }

    try {
        Write-Host "[INDIRILIYOR $($completed + $skipped + 1)/$($assets.Count)] $fileName"
        if (Test-Path $temporary) {
            Remove-Item -Force $temporary
        }
        Invoke-WebRequest -Uri $url -OutFile $temporary -UseBasicParsing
        if ((Get-Item $temporary).Length -le 0) {
            throw "Indirilen dosya bos."
        }
        Move-Item -Force $temporary $target
        $completed++
    }
    catch {
        if (Test-Path $temporary) {
            Remove-Item -Force $temporary
        }
        $failed += $fileName
        Write-Warning "$fileName indirilemedi: $($_.Exception.Message)"
    }
}

Write-Host ""
Write-Host "Tamamlandi : $completed"
Write-Host "Atlandi    : $skipped"
Write-Host "Basarisiz  : $($failed.Count)"

if ($failed.Count -gt 0) {
    Write-Host "Basarisiz dosyalar:"
    $failed | ForEach-Object { Write-Host "  $_" }
    exit 1
}
