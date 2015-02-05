From: Philipp =?utf-8?b?VMO2bGtl?= <philipp.toelke@fos4x.de>
Subject: Re: [PATCH-rt] rtmutex/rt: don't BUG for -EDEADLK when =?utf-8?b?ZGV0ZWN0X2RlYWRsb2Nr?= is off
Date: Thu, 5 Feb 2015 07:58:56 +0000 (UTC)
Message-ID: <loom.20150205T085239-980@post.gmane.org>
References: <1413418164-9405-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:53642 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751193AbbBEIAG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 5 Feb 2015 03:00:06 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1YJHM4-0004We-4I
	for linux-rt-users@vger.kernel.org; Thu, 05 Feb 2015 09:00:04 +0100
Received: from pd907f7af.dip0.t-ipconnect.de ([217.7.247.175])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Thu, 05 Feb 2015 09:00:04 +0100
Received: from philipp.toelke by pd907f7af.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Thu, 05 Feb 2015 09:00:04 +0100
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

SGkgZXZlcnlib2R5LAoKUGF1bCBHb3J0bWFrZXIgPHBhdWwuZ29ydG1ha2VyIDxhdD4gd2luZHJpdmVyLmNvbT4gd3JpdGVzOgo+ICAtdGhpcyBwYXRjaCBpcyBhZ2FpbnN0IDMuMTAtcnQsIGJ1dCB0aGUgY29kZSBmb3IgYWxsIHJlY2VudCAtcnQKPiAgIHRoYXQgaW5jbHVkZSB0aGUgcmVjZW50IGxpbnV4LXN0YWJsZSBydG11dGV4IGNoYW5nZXMgc2hvdWxkIGhhdmUKPiAgIHRoZSBzYW1lIGlzc3VlLiAgW1RoZSAzLjE0LXJ0IGhhcyBhIHRyaXZpYWwgcGF0aCBjaGFuZ2Ugd2hlcmUgdGhlCj4gICBrZXJuZWwvcnRtdXRleC5jIG9mIHYzLjEwIGJlY29tZXMga2VybmVsL2xvY2tpbmcvcnRtdXRleC5jIGJ1dAo+ICAgYXNpZGUgZnJvbSB0aGF0IGl0IGFwcGxpZXMgdG8gMy4xNCB0b29dCj4gCj4gIC1JJ2QgZ290IGEgcmVwb3J0IG9mIHRoaXMgQlVHX09OIHRyaWdnZXJpbmcgb24gYSB2My40LXJ0IGJhc2VkCj4gICBrZXJuZWw7IHRoYXQga2VybmVsIHdhcyB1c2luZyBteSBpbnRlZ3JhdGlvbiBvZiB0aGUgdGdseCBydG11dGV4Cj4gICBzdGFibGUgY2hhbmdlcyBpbnRvIDMuNC1ydCBhcyBkZXNjcmliZWQgaGVyZToKPiAJaHR0cHM6Ly9sa21sLm9yZy9s
 a21sLzIwMTQvOS8yMy85NDQKPiAgIGJ1dCB0aGUgcmVsYXRlZCBjb2RlIGluIHJvc3RlZHQncyAzLjEwLjUzLXJ0NTYgKGluIGxpbnV4LXN0YWJsZS1ydCkKPiAgIGFuZCBpbiB0Z2x4J3MgMy4xNC4xMi1ydDkgcGF0Y2ggcXVldWUgaXMgQUZBSUNUIGlkZW50aWNhbC4gIFNvIEkKPiAgIGhhdmUgdG8gY29uY2x1ZGUgdGhhdCBhbnl0aGluZyB1c2luZyB0aGUgc3RhYmxlIHJ0bXV0ZXggY2hhbmdlcwo+ICAgY2FuIGluYWR2ZXJ0ZW50bHkgc3VmZmVyIHRoZSBzYW1lIEJVRyB0cmlnZ2VyLgo+IAo+ICAtdGhpcyBjaGFuZ2UgZ2V0cyB1cyBiYWNrIHRvIHRoZSBwcmUtcnRtdXRleCBzdGFibGUgY29tbWl0IGJlaGF2aW91ciwKPiAgIGJ1dCBJIHN1c3BlY3QgdGhhdCBzbWFydGVyIHBlb3BsZSB0aGFuIG1lIGNhbiBhZHZpc2Ugb24gYSB3YXkgdG8KPiAgIGFjaGlldmUgdGhlIHNhbWUgZW5kIHJlc3VsdC4gIFNvIEknbGwgd2FpdCBiZWZvcmUgYWRkaW5nIGFueXRoaW5nCj4gICB0byB0aGUgbGludXgtc3RhYmxlLXJ0IGJyYW5jaGVzIEknZCBwdXQgaGVyZSBhdDoKPiAJaHR0cHM6Ly9naXQua2VybmVsLm9yZy9jZ2l0L2xpbnV4L2tlcm5lbC9naXQvcGF1bG
 cvbGludXgtc3RhYmxlLXJ0LmdpdAoKV2hhdCBpcyB0aGUgc3RhdHVzIG9mIHRoaXMgcGF0Y2g/IEkgaGF2ZSBhIG1hY2hpbmUgaGVyZSBJIGNhbiBnZXQgdG8gY3Jhc2ggaW4KYWJvdXQgaGFsZiBhbiBob3VyIGJ5IGRvaW5nIGEgYmlkaXJlY3Rpb25hbCBpcGVyZiBhcyBwcm9wb3NlZCBpbgo8aHR0cDovL3RocmVhZC5nbWFuZS5vcmcvZ21hbmUubGludXgucnQudXNlci8xMjY4MT4uCgpGZm9yIHBvc3Rlcml0eTogVGhlIGNvbW1hbmQgaXMgImlwZXJmIC1jIDEuMi4zLjQgLWkgMTAgLWQgLWwgNjRrIC10IDUwNDAwIgp3aGljaCB3b3VsZCBub3JtYWxseSBkbyBhIDE0IGhvdXItaXBlcmYgdGVzdCBhZ2FpbnN0IDEuMi4zLjQuCgpNeSBtYWNoaW5lIGNyYXNoZXMgd2l0aCBib3RoIDMuMTAuNTMtcnQ1NiBhbmQgMy4xNC4yOS1ydDI2LiBBZnRlcgphcHBseWluZyB5b3VyIHBhdGNoIHRvIDMuMTQgdGhlIG1hY2hpbmUgaGFzIG5vdCBjcmFzaGVkIGluIDI0IGhvdXJzLgoKSGF2ZSAic21hcnRlciBwZW9wbGUiIGhhZCBhIGNoYW5jZSB0byBhZHZpc2UgYWJvdXQgdGhpcyBwYXRjaD8gSXMgdGhlcmUgYW55CnJlYXNvbiBub3QgdG8gdXNlIGl0PwoKUmVnYXJk
 cywKUGhpbGlwcCBUw7Zsa2UK

