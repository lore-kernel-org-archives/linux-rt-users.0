Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from lelnx193.ext.ti.com ([198.47.27.77]:14457 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030460AbeCAN25 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 1 Mar 2018 08:28:57 -0500
From: Dan Murphy <dmurphy@ti.com>
Subject: Merge conflict on RT 4.14 to latest stable
Message-ID: <abeee969-3171-da04-ab56-bb0482640e87@ti.com>
Date: Thu, 1 Mar 2018 07:28:42 -0600
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="------------4B436201B119ABF4624D6CA6"
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>, Julia Cartwright <julia@ni.com>

--------------4B436201B119ABF4624D6CA6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hello

We have a merge conflict in kernel/softirq.c when upgrading to the latest stable release

Please help resolve this.

Dan
-- 
------------------
Dan Murphy

--------------4B436201B119ABF4624D6CA6
Content-Type: text/plain; charset="UTF-8";
	name="linux_stable_rt_merge_conflict.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="linux_stable_rt_merge_conflict.txt"

ZGlmZiAtLWNjIGtlcm5lbC9zb2Z0aXJxLmMKaW5kZXggZDA2ODhhNyxlODljM2IwLi4wMDAw
MDAwCi0tLSBhL2tlcm5lbC9zb2Z0aXJxLmMKKysrIGIva2VybmVsL3NvZnRpcnEuYwpAQEAg
LTk1MCwyNyAtNDg2LDE1ICs5NTAsMzEgQEBAIHZvaWQgX190YXNrbGV0X2hpX3NjaGVkdWxl
KHN0cnVjdCB0YXNrbAogIH0KICBFWFBPUlRfU1lNQk9MKF9fdGFza2xldF9oaV9zY2hlZHVs
ZSk7CiAgCisrPDw8PDw8PCBIRUFECiArdm9pZCBfX3Rhc2tsZXRfaGlfc2NoZWR1bGVfZmly
c3Qoc3RydWN0IHRhc2tsZXRfc3RydWN0ICp0KQogK3sKICsJQlVHX09OKCFpcnFzX2Rpc2Fi
bGVkKCkpOwogKwogKwlfX3Rhc2tsZXRfaGlfc2NoZWR1bGUodCk7CiArfQogK0VYUE9SVF9T
WU1CT0woX190YXNrbGV0X2hpX3NjaGVkdWxlX2ZpcnN0KTsKICsKICt2b2lkICB0YXNrbGV0
X2VuYWJsZShzdHJ1Y3QgdGFza2xldF9zdHJ1Y3QgKnQpCisrPT09PT09PQorIHN0YXRpYyBf
X2xhdGVudF9lbnRyb3B5IHZvaWQgdGFza2xldF9hY3Rpb24oc3RydWN0IHNvZnRpcnFfYWN0
aW9uICphKQorKz4+Pj4+Pj4gODUyYTk2MDIwODQ4NjU5YWU3YTAzZWRlMDBkMDIzMTUxZDVm
NzljOAogIHsKIC0Jc3RydWN0IHRhc2tsZXRfc3RydWN0ICpsaXN0OwogKwlpZiAoIWF0b21p
Y19kZWNfYW5kX3Rlc3QoJnQtPmNvdW50KSkKICsJCXJldHVybjsKICsJaWYgKHRlc3RfYW5k
X2NsZWFyX2JpdChUQVNLTEVUX1NUQVRFX1BFTkRJTkcsICZ0LT5zdGF0ZSkpCiArCQl0YXNr
bGV0X3NjaGVkdWxlKHQpOwogK30KICtFWFBPUlRfU1lNQk9MKHRhc2tsZXRfZW5hYmxlKTsK
ICAKIC0JbG9jYWxfaXJxX2Rpc2FibGUoKTsKIC0JbGlzdCA9IF9fdGhpc19jcHVfcmVhZCh0
YXNrbGV0X3ZlYy5oZWFkKTsKIC0JX190aGlzX2NwdV93cml0ZSh0YXNrbGV0X3ZlYy5oZWFk
LCBOVUxMKTsKIC0JX190aGlzX2NwdV93cml0ZSh0YXNrbGV0X3ZlYy50YWlsLCB0aGlzX2Nw
dV9wdHIoJnRhc2tsZXRfdmVjLmhlYWQpKTsKIC0JbG9jYWxfaXJxX2VuYWJsZSgpOwogK3N0
YXRpYyB2b2lkIF9fdGFza2xldF9hY3Rpb24oc3RydWN0IHNvZnRpcnFfYWN0aW9uICphLAog
KwkJCSAgICAgc3RydWN0IHRhc2tsZXRfc3RydWN0ICpsaXN0KQogK3sKICsJaW50IGxvb3Bz
ID0gMTAwMDAwMDsKICAKICAJd2hpbGUgKGxpc3QpIHsKICAJCXN0cnVjdCB0YXNrbGV0X3N0
cnVjdCAqdCA9IGxpc3Q7Cg==
--------------4B436201B119ABF4624D6CA6--
