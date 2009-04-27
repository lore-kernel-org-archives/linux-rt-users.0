From: Stefan Agner <stefan.agner@yahoo.com>
Subject: [PATCH] sched_clock implementation for orion platforms
Date: Mon, 27 Apr 2009 04:11:30 -0700 (PDT)
Message-ID: <584907.38379.qm@web59806.mail.ac4.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-2013681764-1240830690=:38379"
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from n4b.bullet.mail.ac4.yahoo.com ([76.13.13.74]:42688 "HELO
	n4b.bullet.mail.ac4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752386AbZD0LRQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 27 Apr 2009 07:17:16 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--0-2013681764-1240830690=:38379
Content-Type: text/plain; charset=us-ascii

Hello,

First of all, altough I added Patch in the subject and post it here, I don't think that this patch should be applied to rt tree... Read the rest of the email to see why...

On my ARM SoC with a marvell orion chip I get weird cpu usage values in top when I load my kernel module (different processes shows very high cpu usage). My kernel module sends ethernet frames every 200us. Therefor I use hrtimers and send this network frames in the callback method of the timer. I use 2.6.29.1-rt9. All the involved processes (IRQ-21 (irq of the network interface), sirq-net-rx, sirq-hrtimer) gets randomly high cpu usage. Sometimes I get no cpu usage at all. Its different each time I load my module. Sometimes IRQ-21 gets high cpu load, sometimes sirq-net-rx... Load average seems to show realistic values (~0.6). 
This have a unpleasant side effect: Due to the limited runtime for rt tasks (in /proc/sys/kernel/sched_rt_runtime_us), i get a delay of 50ms once every second. When i disable the limit (echo -1 >/proc/sys/kernel/sched_rt_runtime_us) i don't get this delay. However, it would be great if the cpu usage per process would be fixed anyway....
Therefor I implemented a sched_clock implementation for my orion platform (see attached patch). I tested the values that sched_clock returns, it should be ok! But it still doesn't work...

Any ideas?

Thanks
Stefan aka falstaff


      
--0-2013681764-1240830690=:38379
Content-Type: text/x-patch; name="sched_clock-implementation-for-orion-platforms.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="sched_clock-implementation-for-orion-platforms.patch"

RnJvbSA5YWIzYzYwMzBkYzAxZmZlNDA2NWMzMzRjYWMxYTA3YzBmZjZhZjVk
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTdGVmYW4gQWduZXIg
PHN0ZWZhbi5hZ25lckB5YWhvby5jb20+CkRhdGU6IE1vbiwgMjcgQXByIDIw
MDkgMTE6MTE6MTggKzAyMDAKU3ViamVjdDogW1BBVENIXSBzY2hlZF9jbG9j
ayBpbXBsZW1lbnRhdGlvbiBmb3Igb3Jpb24gcGxhdGZvcm1zCgotLS0KIGFy
Y2gvYXJtL3BsYXQtb3Jpb24vdGltZS5jIHwgICAzNSArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlcyBjaGFuZ2VkLCAzNSBp
bnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtL3BsYXQtb3Jpb24vdGltZS5jIGIvYXJjaC9hcm0vcGxhdC1vcmlv
bi90aW1lLmMKaW5kZXggNmZhMjkyMy4uZjg3M2Y2NyAxMDA2NDQKLS0tIGEv
YXJjaC9hcm0vcGxhdC1vcmlvbi90aW1lLmMKKysrIGIvYXJjaC9hcm0vcGxh
dC1vcmlvbi90aW1lLmMKQEAgLTE3LDYgKzE3LDggQEAKICNpbmNsdWRlIDxs
aW51eC9pcnEuaD4KICNpbmNsdWRlIDxhc20vbWFjaC90aW1lLmg+CiAjaW5j
bHVkZSA8bWFjaC9oYXJkd2FyZS5oPgorI2luY2x1ZGUgPGxpbnV4L3NjaGVk
Lmg+CisjaW5jbHVkZSA8bGludXgvY250MzJfdG9fNjMuaD4KIAogLyoKICAq
IE51bWJlciBvZiB0aW1lciB0aWNrcyBwZXIgamlmZnkuCkBAIC0zOSw2ICs0
MSwzNSBAQCBzdGF0aWMgdTMyIHRpY2tzX3Blcl9qaWZmeTsKIAogCiAvKgor
ICogT3Jpb24ncyBzY2hlZF9jbG9jayBpbXBsZW1lbnRhdGlvbi4gSXQgaGFz
IGEgcmVzb2x1dGlvbgorICogb2YgYXQgbGVhc3QgNy41bnMgKDEzM01IeiBU
Q0xLKSBhbmQgYSBtYXhpbXVtIHZhbHVlIG9mCisgKiAzMiBzZWNvbmRzLgor
ICovCisjZGVmaW5lIE9SSU9OQ0xLMk5TX1NDQUxFX0ZBQ1RPUiAyMAorCitz
dGF0aWMgdW5zaWduZWQgbG9uZyBvcmlvbjJuc19zY2FsZTsKKworc3RhdGlj
IHZvaWQgX19pbml0IHNldF9vcmlvbjJuc19zY2FsZSh1bnNpZ25lZCBsb25n
IG9yaW9uX3JhdGUpCit7CisJdW5zaWduZWQgbG9uZyBsb25nIHYgPSAoKHVu
c2lnbmVkIGxvbmcgbG9uZylOU0VDX1BFUl9TRUMpIDw8IE9SSU9OQ0xLMk5T
X1NDQUxFX0ZBQ1RPUjsKKwlkb19kaXYodiwgb3Jpb25fcmF0ZSk7CisJLyoK
KwkgKiBXZSB3YW50IGFuIGV2ZW4gdmFsdWUgdG8gYXV0b21hdGljYWxseSBj
bGVhciB0aGUgdG9wIGJpdAorCSAqIHJldHVybmVkIGJ5IGNudDMyX3RvXzYz
KCkgd2l0aG91dCBhbiBhZGRpdGlvbmFsIHJ1biB0aW1lCisJICogaW5zdHJ1
Y3Rpb24uIFNvIGlmIHRoZSBMU0IgaXMgMSB0aGVuIHJvdW5kIGl0IHVwLgor
CSAqLworCWlmKHYgJiAxKQorCQl2Kys7CisJb3Jpb24ybnNfc2NhbGUgPSB2
OworfQorCit1bnNpZ25lZCBsb25nIGxvbmcgc2NoZWRfY2xvY2sodm9pZCkK
K3sKKwl1bnNpZ25lZCBsb25nIGxvbmcgdiA9IGNudDMyX3RvXzYzKDB4ZmZm
ZmZmZmYgLSByZWFkbChUSU1FUjBfVkFMKSk7CisJcmV0dXJuICh2ICogb3Jp
b24ybnNfc2NhbGUpID4+IE9SSU9OQ0xLMk5TX1NDQUxFX0ZBQ1RPUjsKK30K
KworLyoKICAqIENsb2Nrc291cmNlIGhhbmRsaW5nLgogICovCiBzdGF0aWMg
Y3ljbGVfdCBvcmlvbl9jbGtzcmNfcmVhZCh2b2lkKQpAQCAtMTc2LDYgKzIw
NywxMCBAQCB2b2lkIF9faW5pdCBvcmlvbl90aW1lX2luaXQodW5zaWduZWQg
aW50IGlycSwgdW5zaWduZWQgaW50IHRjbGspCiAKIAl0aWNrc19wZXJfamlm
ZnkgPSAodGNsayArIEhaLzIpIC8gSFo7CiAKKwkvKgorCSAqIFNldCBzY2Fs
ZSBmb3Igc2NoZWRfY2xvY2sKKwkgKi8KKwlzZXRfb3Jpb24ybnNfc2NhbGUo
dGNsayk7CiAKIAkvKgogCSAqIFNldHVwIGZyZWUtcnVubmluZyBjbG9ja3Nv
dXJjZSB0aW1lciAoaW50ZXJydXB0cwotLSAKMS41LjYuMwoK

--0-2013681764-1240830690=:38379--

