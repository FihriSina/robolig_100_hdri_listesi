ROBOLIG ICIN 100 FARKLI POLY HAVEN HDRI/EXR
============================================================

Bu pakette:

1. robolig_100_hdri.csv
   - 100 HDRI'nin Poly Haven sayfasi
   - Dogrudan 2K EXR indirme adresi
   - Ortam grubu

2. indir_robolig_100_hdri.ps1
   - Windows PowerShell ile 100 dosyayi otomatik indirir.
   - Mevcut dosyalari yeniden indirmez.
   - Yarim kalan indirmeleri .part dosyasinda tutar ve hata halinde temizler.

KULLANIM
------------------------------------------------------------

ZIP'i proje klasorune cikartin. PowerShell'i generate.py'nin bulundugu
proje kokunde acin.

2K EXR indirmek icin:

  powershell -ExecutionPolicy Bypass -File .\indir_robolig_100_hdri.ps1 -Resolution 2k -Destination .\backgrounds

Daha az disk kullanmak icin 1K EXR:

  powershell -ExecutionPolicy Bypass -File .\indir_robolig_100_hdri.ps1 -Resolution 1k -Destination .\backgrounds

NOTLAR
------------------------------------------------------------

- 2K paket toplamda yaklasik 1-2+ GB disk ve indirme kullanabilir.
- 1K dosyalar daha kucuktur ve hizli sentetik veri uretimi icin genellikle yeterlidir.
- Secilen 100 varligin hicbiri kullanicinin paylastigi mevcut 44 dosya adiyla ayni degildir.
- Liste endustriyel atolye/depo/garaj, kapali salon/okul/gym, beton/asfalt dis saha
  ve kontrollu studyo aydinlatmalarindan olusur.
- Tum varliklar Poly Haven resmi varlik sayfalarindan secilmistir.
- Poly Haven varliklari CC0 lisanslidir.

Poly Haven HDRI katalogu:
  https://polyhaven.com/hdris

Poly Haven lisansi:
  https://polyhaven.com/license

TEKNOFEST Robolig:
  https://www.teknofest.org/tr/yarismalar/teknofest-robolig-yarismasi/
