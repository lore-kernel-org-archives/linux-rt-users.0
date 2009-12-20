From: Carsten Emde <Carsten.Emde@osadl.org>
Subject: Re: More RT Test Programs
Date: Mon, 21 Dec 2009 00:49:26 +0100
Message-ID: <4B2EB806.301@osadl.org>
References: <388070393.1730301260825543554.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>	 <4B26B838.1080303@osadl.org>	 <alpine.LFD.2.00.0912150053010.6441@localhost.localdomain>	 <4B2E8C51.3040302@osadl.org> <520f0cf10912201451q55c823cbia07c23f4a3bbe98c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030406080408080607060907"
Cc: Clark Williams <williams@redhat.com>,
	linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:41572 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756039AbZLTXub (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 20 Dec 2009 18:50:31 -0500
In-Reply-To: <520f0cf10912201451q55c823cbia07c23f4a3bbe98c@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a multi-part message in MIME format.
--------------030406080408080607060907
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

John,

> [..] I'll be posting some more tomorrow.
Okay, great.

I have found an issue with all source files of the new tests. At some
stage between the original files and Clark's tree, the line delimiters
changed from NL to CR/NL. Would be great, if you could move this back to NL.

A second issue is related to the removal of the getcpu() definition.
There is a leftover in svsematest.c which should also be removed for
consistency. However, this and the other tests no longer compile in EL5
without this definition - should we better revert this and provide a
working recognition through "grep sched_getcpu
/usr/include/bits/sched.h"? Or is EL5 irrelevant in this context? I
still have an EL5 test machine where all RT kernels are tested.

Another issue is in the file backfire.c After you removed the line
>> -	sed s/__VERSION_STRING__/$(VERSION_STRING)/ [..]
from the Makefile, the driver is producing the rather ugly syslog message:
  backfire driver v__VERSION_STRING__
instead of
  backfire driver v0.57
or similar.

We better completely remove the version display.

Signed-off-by: Carsten Emde <C.Emde@osadl.org>

--------------030406080408080607060907
Content-Type: text/x-patch;
 name="fix-backfire-version-display.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="fix-backfire-version-display.patch"

LS0tIGJhY2tmaXJlLmMtb3JpZwkyMDA5LTEyLTIwIDIyOjQwOjQ4LjAwMDAwMDAwMCArMDEw
MAorKysgYmFja2ZpcmUuYwkyMDA5LTEyLTIwIDIyOjQxOjQwLjAwMDAwMDAwMCArMDEwMApA
QCAtMTMyLDcgKzEzMiw3IEBACiAJaWYgKHJldCkNCiAJCXByaW50ayhLRVJOX0VSUiAiYmFj
a2ZpcmU6IGNhbid0IHJlZ2lzdGVyIGR5bmFtaWMgbWlzYyBkZXZpY2VcbiIpOw0KIAllbHNl
DQotCQlwcmludGsoS0VSTl9JTkZPICJiYWNrZmlyZSBkcml2ZXIgdl9fVkVSU0lPTl9TVFJJ
TkdfXyBtaXNjIGRldmljZSAlZFxuIiwNCisJCXByaW50ayhLRVJOX0lORk8gImJhY2tmaXJl
IGRyaXZlciBtaXNjIGRldmljZSAlZFxuIiwKIAkJCWJhY2tmaXJlX2Rldi5taW5vcik7DQog
CXJldHVybiByZXQ7DQogfQ0K
--------------030406080408080607060907--
