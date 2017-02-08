From: "Patel, Vedang" <vedang.patel@intel.com>
Subject: Regression on rt kernel while using POSIX timers
Date: Wed, 8 Feb 2017 18:41:25 +0000
Message-ID: <1486579285.29816.105.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "Hart, Darren" <darren.hart@intel.com>
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:43616 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751815AbdBHSoo (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 8 Feb 2017 13:44:44 -0500
Content-Language: en-US
Content-ID: <F0130B1CCDBB90469F162CB13C1B680A@intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

SGkswqANCg0KSSBhbSB0cnlpbmcgdG8gcmVwcm9kdWNlIHJlc3VsdHMgaW4gdGhlIEV4cGVjdGVk
IFJlc3VsdHMgc2VjdGlvbiBvbsKgaHR0DQpwczovL3J0Lndpa2kua2VybmVsLm9yZy9pbmRleC5w
aHAvQ3ljbGljdGVzdA0KDQpUaGUgcmVzdWx0cyBmb3IgdGhlIFBPU0lYIHRpbWVycyB3ZXJlIG5v
dCBhcyBJIGV4cGVjdGVkLiBUaGUgbGF0ZW5jeQ0KZm9yIHJlYWwtdGltZSBrZXJuZWwgKHY0Ljku
NC1ydDIpIHdhcyB3b3JzZSBjb21wYXJlZCB0byB0aGUgbWFpbmxpbmUNCmtlcm5lbCAodjQuOS40
KS4gSW4gYWxtb3N0IGFsbCB0aGUgY2FzZXMsIHRoZSBsYXRlbmN5IGlzIGFsbW9zdCBkb3VibGVk
DQrCoHdpdGggdGhlIG1heCB2YWx1ZSByZWFjaGluZyBhYm91dCAxMCB0aW1lcyB3aGVuIHBlcmZv
cm1pbmcgdGhlIHRlc3RzDQp1bmRlciBsb2FkLg0KDQpJIHdhcyB1c2luZyBhIHN5c3RlbSB3aXRo
IEludGVswq4gQXRvbSBwcm9jZXNzb3IgQzI3NTggYW5kIHJ1bm5pbmcgdGhlDQpmb2xsb3dpbmcg
Y29tbWFuZHMgd2l0aCBubyBsb2FkIGFuZCAxMDAlIGxvYWQ6DQoqIGN5Y2xpY3Rlc3QgLXQxIC1w
IDgwIC1pIDEwMDAwIC1sIDEwMDAwDQoqIGN5Y2xpY3Rlc3QgLXQxIC1wIDgwIC1pIDUwMCAtbCAx
MDAwMDANCg0KSSB3YXMgdXNpbmcgaGFja2JlbmNoIGZvciBnZW5lcmF0aW5nIHRoZSBsb2FkcyBh
cyBmb2xsb3dzOg0KDQouL2hhY2tiZW5jaCAtcCAtcyAxMDAgLWwgMTAwMDAgLWYgMTAwIC1QICYN
Cg0KRG9lcyBhbnlvbmUgaGF2ZSBrbm93IG9mIGFueSBrbm93biBidWdzIHdoaWNoIG1pZ2h0IGJl
IGNhdXNpbmcgdGhpcw0KcmVncmVzc2lvbj/CoA0KDQpUaGFua3MsDQpWZWRhbmcgUGF0ZWwNClNv
ZnR3YXJlIEVuZ2luZWVyDQpJbnRlbCBDb3Jwb3JhdGlvbg==
