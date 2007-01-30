From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: 2.6.20-rc6-rt4 register_cpu_notification undefined
Date: Tue, 30 Jan 2007 11:26:49 -0000 (WET)
Message-ID: <23932.213.58.131.130.1170156409.squirrel@www.rncbc.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20070130112649_50732"
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: "Ingo Molnar" <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp2.netcabo.pt ([212.113.174.29]:37607 "EHLO
	exch01smtp09.hdi.tvcabo" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964865AbXA3L1s (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 30 Jan 2007 06:27:48 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

------=_20070130112649_50732
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 8bit

Hi,

Just to let you know that this my simple patch solves the
'register_cpu_notifier' being undefined when SMP is set but not
HOTPLUG_CPU.

Dunno if its the right thing, tho.

Cheers
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org
------=_20070130112649_50732
Content-Type: application/octet-stream;
      name="linux-2.6.20-rc6-rt4-cpu.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.20-rc6-rt4-cpu.patch"

LS0tIGxpbnV4L2tlcm5lbC9jcHUuYy5vcmlnCTIwMDctMDEtMjUgMDI6MTk6MjguMDAwMDAwMDAw
ICswMDAwCisrKyBsaW51eC9rZXJuZWwvY3B1LmMJMjAwNy0wMS0zMCAwOTo0MzoyMi4wMDAwMDAw
MDAgKzAwMDAKQEAgLTc1LDEwICs3NSwxMCBAQAogCXJldHVybiByZXQ7CiB9CiAKLSNpZmRlZiBD
T05GSUdfSE9UUExVR19DUFUKLQogRVhQT1JUX1NZTUJPTChyZWdpc3Rlcl9jcHVfbm90aWZpZXIp
OwogCisjaWZkZWYgQ09ORklHX0hPVFBMVUdfQ1BVCisKIHZvaWQgdW5yZWdpc3Rlcl9jcHVfbm90
aWZpZXIoc3RydWN0IG5vdGlmaWVyX2Jsb2NrICpuYikKIHsKIAltdXRleF9sb2NrKCZjcHVfYWRk
X3JlbW92ZV9sb2NrKTsK
------=_20070130112649_50732--
