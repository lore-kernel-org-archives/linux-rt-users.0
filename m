From: "Pradyumna Sampath" <pradyumna.sampath@gmail.com>
Subject: [PATCH] Powerpc compiler error fix for 2.6.21-rt8
Date: Tue, 29 May 2007 09:54:49 +0530
Message-ID: <f87351060705282124q6d6b1562ic1dd4da4b8a62886@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_130582_14329058.1180412689748"
To: linuxppc-embedded@ozlabs.org, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:57951 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbXE2EYu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 29 May 2007 00:24:50 -0400
Received: by py-out-1112.google.com with SMTP id a29so691007pyi
        for <linux-rt-users@vger.kernel.org>; Mon, 28 May 2007 21:24:50 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

------=_Part_130582_14329058.1180412689748
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi everyone,

Attached is a small patch to fix compile time errors which is broken
in 2.6.21-rt8 for powerpc.

thanks
regards
prady

------=_Part_130582_14329058.1180412689748
Content-Type: text/x-patch; name=2_6_21_rt8_powerpc_rt_compile_fix.diff;
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f29vqqfj
Content-Disposition: attachment; filename="2_6_21_rt8_powerpc_rt_compile_fix.diff"

ZGlmZiAtdXIgbGF0ZXN0L2xpbnV4LTIuNi4yMS9hcmNoL3Bvd2VycGMva2VybmVsL3RpbWUuYyBs
aW51eC0yLjYuMjEvYXJjaC9wb3dlcnBjL2tlcm5lbC90aW1lLmMKLS0tIGxhdGVzdC9saW51eC0y
LjYuMjEvYXJjaC9wb3dlcnBjL2tlcm5lbC90aW1lLmMJMjAwNy0wNS0yOSAwOTo1ODoxMi4wMDAw
MDAwMDAgKzA1MzAKKysrIGxpbnV4LTIuNi4yMS9hcmNoL3Bvd2VycGMva2VybmVsL3RpbWUuYwky
MDA3LTA1LTI5IDA4OjU4OjU2LjAwMDAwMDAwMCArMDUzMApAQCAtOTUsNiArOTUsOCBAQAogI2Rl
ZmluZSBTQ0FMRV9YU0VDKHhzZWMsIG1heCkJbXVsaHd1KCh4c2VjKSA8PCAxMiwgbWF4KQogI2Vu
ZGlmCiAKK3Vuc2lnbmVkIGxvbmcgY3B1X2toejsgIC8qIERldGVjdGVkIGFzIHdlIGNhbGlicmF0
ZSB0aGUgVFNDICovCitFWFBPUlRfU1lNQk9MKGNwdV9raHopOwogdW5zaWduZWQgbG9uZyB0Yl90
aWNrc19wZXJfamlmZnk7CiB1bnNpZ25lZCBsb25nIHRiX3RpY2tzX3Blcl91c2VjID0gMTAwOyAv
KiBzYW5lIGRlZmF1bHQgKi8KIEVYUE9SVF9TWU1CT0wodGJfdGlja3NfcGVyX3VzZWMpOwpPbmx5
IGluIGxpbnV4LTIuNi4yMS9hcmNoL3Bvd2VycGMva2VybmVsOiB2bWxpbnV4LmxkcwpPbmx5IGlu
IGxpbnV4LTIuNi4yMS9zY3JpcHRzL2tjb25maWc6IG1jb25mCg==
------=_Part_130582_14329058.1180412689748--
