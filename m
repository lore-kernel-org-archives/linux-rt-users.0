From: Marcus lu <marcus.lu@delta.com.tw>
Subject: kernel 3.2.0 with rt patch-3.2-rt10.patch.gz hangs up Ethernet module
Date: Tue, 16 Jun 2015 07:58:06 +0000 (UTC)
Message-ID: <loom.20150616T094748-860@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:39299 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753815AbbFPIFK (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 16 Jun 2015 04:05:10 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1Z4lrk-0001XV-2A
	for linux-rt-users@vger.kernel.org; Tue, 16 Jun 2015 10:05:05 +0200
Received: from 60-249-238-102.HINET-IP.hinet.net ([60.249.238.102])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Jun 2015 10:05:04 +0200
Received: from marcus.lu by 60-249-238-102.HINET-IP.hinet.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Jun 2015 10:05:04 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

SGkgU2lyIDoKCkkgdHJ5IGtlcm5lbCB2ZXJzaW9uIDMuMi4wIGFuZCBSVCBwYXRjaCBwYXRjaC0zLjItcnQxMC5wYXRjaC5neiBvbiBUSSAKQU0zMzV4IEVWTShDb3J0ZXggQTgpLCBJIGZpbmQgb3V0IGEgcHJvYmxlbS4gCgpNeSB0ZXN0IHN0ZXBzIGFzIGJlbG93IDoKCjEuIEluIHB1cmUgbGludXggZGlyZWN0b3J5LCBJIHVzZSB6Y2F0IC4uLy4uL3BhdGNoLTMuMi1ydDEwLnBhdGNoLmd6IHwgCnBhdGNoIC1wMSBjb21tYW5kLiAocHVyZSBtZWFucyBJIGluc3RhbGwgVEnigJlzIFNESyA6IHRpLXNkay1hbTMzNXgtZXZtLQowLjYuMDAuMDAuMDAtbGludXgteDg2LWluc3RhbGwuYmluIHdpdGhvdXQgY2hhbmdpbmcgYW55dGhpbmcpIAoKSW4gbGludXggZGlyZWN0b3J5IDogCjIuIG1ha2UgQVJDSD1hcm0gQ1JPU1NfQ09NUElMRT0vaG9tZS9tYXJjdXMvdGktc2RrLWFtMzM1eC1ldm0tCjA2LjAwLjAwLjAwL2xpbnV4LWRldmtpdC9zeXNyb290cy9pNjg2LWFyYWdvLWxpbnV4L3Vzci9iaW4vYXJtLWxpbnV4LQpnbnVlYWJpaGYtIHRpc2RrX2FtMzM1eC1ldm1fZGVmY29uZmlnIAozLiBtYWtlIEFSQ0g9YXJtIENST1NTX0NPTVBJTEU9L2hvbWUvbWFyY3Vz
 L3RpLXNkay1hbTMzNXgtZXZtLQowNi4wMC4wMC4wMC9saW51eC1kZXZraXQvc3lzcm9vdHMvaTY4Ni1hcmFnby1saW51eC91c3IvYmluL2FybS1saW51eC0KZ251ZWFiaWhmLSBtZW51Y29uZmlnIAo0LiBTZWxlY3Qga2VybmVsIEZlYXR1cmVzIGFuZCBwcmVlbXB0aW9uIE1vZGVsIEZ1bGx5IFByZWVtcHRpYmxlIApLZXJuZWwoUlQpIAo1LiBTYXZlIC5jb25maWcgCjYuIG1ha2UgQVJDSD1hcm0gQ1JPU1NfQ09NUElMRT0vaG9tZS9tYXJjdXMvdGktc2RrLWFtMzM1eC1ldm0tCjA2LjAwLjAwLjAwL2xpbnV4LWRldmtpdC9zeXNyb290cy9pNjg2LWFyYWdvLWxpbnV4L3Vzci9iaW4vYXJtLWxpbnV4LQpnbnVlYWJpaGYtIHVJbWFnZSAKNy4gQWZ0ZXIgYnVpbGRpbmcgc3VjY2Vzc2Z1bGx5LCBjb3B5IHVJbWFnZSB0byBTRCBjYXJkIGFuZCBwb3dlciBvbiB0aGUgCkVWTSBib2FyZC4KCjguIEV4ZWN1dGluZyBpcGVyZiAtcyBvbiBsaW51eCBwbGF0Zm9ybSBhbmQgZXhlY3V0ZSBpcGVyZi5leGUg4oCTYyAKMTAuMC4wLjE4MCDigJN3IDEwME0g4oCTdCAxMjAwIOKAk0kgMTAgb24gd2luIDcgcGxhdGZvcm0uIAo5LiBFdGhlcm5ldCBtb2R1bGUgb24gbGludX
 ggcGxhdGZvcm0gaGFuZ3MgdXAuKEkgY2Fu4oCZdCBwaW5nIG15IFBDIGluIApsaW51eCBwbGF0Zm9ybSBldmVuIHRob3VnaCBJIHVzZSBpcGNvbmZpZyBldGgwIGRvd24gYW5kIGlwY29uZmlnIGV0aDAgdXAgCmNvbW1hbmQpIAoKQ291bGQgeW91IGdpdmUgbWUgc29tZSBzdWdnZXN0aW9uPwoKSSBoYXZlIHRyaWVkIG5vdCB0byBlbmFibGUgUlQgc3VwcG9ydCBhbmQgdXNlIGlwZXJmIHRvIHRlc3QsIHRoZSB0ZXN0aW5nIApyZXN1bHQgaXMgZ29vZC4KCkJlc3QgcmVnYXJkLAoKTWFyY3Vz

