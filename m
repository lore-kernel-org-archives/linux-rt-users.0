From: Clark Williams <williams@redhat.com>
Subject: Re: [RT] [RFC] simple SMI detector
Date: Sun, 25 Jan 2009 09:04:54 -0600
Message-ID: <20090125090454.753c05dd@torg>
References: <1232751312.3990.59.camel@perihelion.bos.jonmasters.org>
	<75b66ecd0901231833j2fda4554sb0f47457ab838566@mail.gmail.com>
	<alpine.LFD.2.00.0901241716540.3424@localhost.localdomain>
	<1232845026.3990.71.camel@perihelion.bos.jonmasters.org>
	<1232849565.29318.112.camel@sven.thebigcorporation.com>
	<20090125040246.GE9216@mit.edu>
	<alpine.LFD.2.00.0901251035050.3424@localhost.localdomain>
	<195c7a900901250349t6c0cdc73gdbd71a9f87151d72@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Cc: Thomas Gleixner <tglx@linutronix.de>, Theodore Tso <tytso@mit.edu>,
	Sven-Thorsten Dietrich <sdietrich@novell.com>,
	Jon Masters <jcm@redhat.com>,
	Lee Revell <rlrevell@joe-job.com>,
	linux-rt-users@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Bastien ROUCARIES <roucaries.bastien@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:60477 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752832AbZAYPFj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 25 Jan 2009 10:05:39 -0500
In-Reply-To: <195c7a900901250349t6c0cdc73gdbd71a9f87151d72@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

LS0tLS1CRUdJTiBQR1AgU0lHTkVEIE1FU1NBR0UtLS0tLQ0KSGFzaDogU0hBMQ0KDQpPbiBTdW4s
IDI1IEphbiAyMDA5IDEyOjQ5OjE4ICswMTAwDQpCYXN0aWVuIFJPVUNBUklFUyA8cm91Y2FyaWVz
LmJhc3RpZW5AZ21haWwuY29tPiB3cm90ZToNCg0KPiBPbiBTdW4sIEphbiAyNSwgMjAwOSBhdCAx
MDo0MCBBTSwgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+IHdyb3RlOg0KPiA+
DQo+ID4gTXkgY29uY2VybiBhYm91dCB0aGUgU01JIGRpc2FibGUgbW9kdWxlIGlzIHRoYXQgaXQg
Y2FuIGRhbWFnZSBKb2UNCj4gPiB1c2VycyBoYXJkd2FyZS4gSSBoYXZlIGF0IGxlYXN0IHR3byBy
ZXBvcnRzIHdoZXJlIHRoZSBDUFUgZ290IGZyaWVkDQo+ID4gYW5kIHNvbWUgb3RoZXJzIHdoZXJl
IHBlb3BsZSBnb3QgY29uZnVzZWQgYmVjYXVzZSBjaGlwcyBzdGFydGVkDQo+ID4gYmVoYXZpbmcg
d2VpcmQgYW5kIGl0IHRvb2sgcXVpdGUgYSB0aW1lIHRvIGZpZ3VyZSBvdXQgdGhhdCB0aGV5IHVz
ZWQNCj4gPiB0aGUgU01JIGRpc2FibGVyLiBBIGJpZyBmYXQgd2FybmluZyBhYm91dCB0aGlzIGNv
ZGUgaXMgZGVmaW5pdGVseQ0KPiA+IG5lY2Vzc2FyeS4NCj4gPg0KPiA+IFRoYW5rcywNCj4gDQo+
IA0KPiBJIHN1cHBvc2UgdGhlIG5vbiBqb2UgdXNlciBjb3VsZCBmbGFzaCB0aGVpciBtb3RoZXJi
b2FyZCB3aXRoDQo+IGxpbnV4Y29yZSBhbmQgdGhlcmVmb3JlIGRvIG5vdCBkaXN0cnViIGJ5IFNN
SSA6KQ0KPiANCg0KRXhjZXB0IGZvciB0aGUgZmFjdCB0aGF0IGxpbnV4Y29yZSBpcyB1bmF3YXJl
IG9mIHRoZSBzcGVjaWZpYw0KcmVxdWlyZW1lbnRzIGEgcGFydGljdWxhciBtb3RoZXJib2FyZCBo
YXMgZm9yIHRoZXJtYWwgbWFuYWdlbWVudC4NCg0KVHVybmluZyBvZmYgU01JJ3MgdW5jb25kaXRp
b25hbGx5IGlzIGEgKmJhZCogaWRlYS4gQmV0dGVyIHRvIHN0YXJ0DQp0ZWxsaW5nIGhhcmR3YXJl
IHZlbmRvcnMgdGhhdCB3ZSBjYW4ndCB1c2UgdGhlaXIgcGxhdGZvcm0gYmVjYXVzZSBvZg0KdW5l
eHBsYWluZWQgbGF0ZW5jaWVzICh3aGljaCB3ZSBwcmVzdW1lIHRvIGJlIFNNSSdzKS4gDQoNCkNs
YXJrDQotLS0tLUJFR0lOIFBHUCBTSUdOQVRVUkUtLS0tLQ0KVmVyc2lvbjogR251UEcgdjIuMC4x
MCAoR05VL0xpbnV4KQ0KDQppRVlFQVJFQ0FBWUZBa2w4ZjVvQUNna1FIeXVqLytUVEVwMEp1d0Nm
UWFhdWdVK01ZOG5XSEtzdlh1Vk5tRTZYDQpJRVlBb01GbjcwQks5TmN6ekhJMVhublF3eTdieC9K
YQ0KPWFSS2wNCi0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQ0K
