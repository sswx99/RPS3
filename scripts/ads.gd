extends Node

var admob = null;
var isAdsReal = false; # change it later
var isEnabled = true;

var bannerId = "ca-app-pub-3940256099942544/6300978111"; #test id 
var interstitialId = "ca-app-pub-3940256099942544/1033173712"; #test id
var bannerOnTop = true;

func _ready():
	if isEnabled && Engine.has_singleton("AdMob"):
		admob = Engine.get_singleton("AdMob");
		if admob:
			print("Admob module loaded!");
		
		admob.init(isAdsReal,get_instance_id());
		admob.loadBanner(bannerId,bannerOnTop);
		admob.loadInterstitial(interstitialId);


	else:
		print("Export has not admob module!");

# Banner Methods
# --------------------

func showBannerAd():
	if admob:
		admob.showBanner();
		print("banner");

func hideBannerAd():
	if admob:
		admob.hideBanner();

func _on_admob_ad_loaded():
	print("Admob banner ad loaded!");

func _on_admob_network_error():
	print("Admob banner network error!");

func _on_admob_banner_failed_to_load():
	print("Admob banner failed to load");

# Interstitial Methods
# --------------------

func showInterAd():
	if admob:
		admob.hideBanner();
		admob.showInterstitial();
		print("inter");

func _on_interstitial_close():
	admob.showBanner();

func _on_interstitial_not_loaded():
	print("Interstitial ad not loaded!");

func _on_interstitial_loaded():
	print("Interstitial ad loaded!");
