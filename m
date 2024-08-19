Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000E815E96
	for <linux-rt-users@vger.kernel.org>; Mon, 19 Aug 2024 20:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724100660; cv=none; b=o5K3+crx9qxoQZTMrsKheV/F6TJp2q7R6sOzq7T/sHmsMGaCtQyOCUbmfR5IcvL3yG6AWu1EmfdUyE+wOTy8dcDrDLiT/Jt/6LyIfg4R9EBiH9QZY9FwK1TrmSRRuuJ2rIaG24O2yaoPqnFJ5yC8zX56dQVaByjc5FnaRMn8jGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724100660; c=relaxed/simple;
	bh=ugAKfosvctlYVLHaxsS5k6FJRTlD2DMeojz8dTn2ar0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uM6QThvlSj2z9A8b/OrZ8C/zdL1qTMMIEQJlp89NnTR5GJi4DKokes/zzoJEKCAlVz9ExzptjmRUKiGJX2wlEd9g4hoYUG39FnNzgdHbbI0LUH3c0x19hJ0DPCuvRZSJ+5JacLuoGNhMGoFYqKXAf6yJgip7RIdeVkgxi0QfDsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=imTk6zB0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="imTk6zB0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724100657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ugAKfosvctlYVLHaxsS5k6FJRTlD2DMeojz8dTn2ar0=;
	b=imTk6zB0AZNdqgRt90wJ+WZK3loaTyABrXgegKegRyxdk6aV0o0RzbO+yW/GgTRC/7aSe+
	udsrYlNZrauM/CaQWdhiVmi5Nk/znuwRZfyXGYZpi3FrmAtUCVGRL+Zhh2vhjgWtMoLevw
	9shUZtLhKgWVtxNneBg4j5VA10s1rrY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-ejeCwi0ZMdiW2jSoBt11TQ-1; Mon,
 19 Aug 2024 16:50:56 -0400
X-MC-Unique: ejeCwi0ZMdiW2jSoBt11TQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9249F1955BEF;
	Mon, 19 Aug 2024 20:50:55 +0000 (UTC)
Received: from [10.2.16.120] (unknown [10.2.16.120])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 21A851955BFC;
	Mon, 19 Aug 2024 20:50:53 +0000 (UTC)
Message-ID: <3ac45a341a7ff571a804f55546fbedf89efa3cce.camel@redhat.com>
Subject: Re: [PATCH 2/3] rteval: Upgrade load kernel to linux-6.10.5
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>, RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>, Tomas Glozar <tglozar@redhat.com>,
  Chris White <chwhite@redhat.com>, Anubhav Shelat <sanubhav1000@gmail.com>
Date: Mon, 19 Aug 2024 15:50:53 -0500
In-Reply-To: <20240818194216.299176-3-jkacur@redhat.com>
References: <20240818194216.299176-1-jkacur@redhat.com>
	 <20240818194216.299176-3-jkacur@redhat.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

T24gU3VuLCAyMDI0LTA4LTE4IGF0IDE1OjQyIC0wNDAwLCBKb2huIEthY3VyIHdyb3RlOgo+IFRo
ZSBvbGRlciBrZXJuZWwgZmFpbHMgdG8gY29tcGlsZSBvbiBuZXdlciB0b29sIGNoYWlucywgc28g
dXBncmFkZQo+IHRoZSBrZXJuZWwgdGhhdCBrY29tcGlsZSBjb21waWxlcyBhcyBhIGxvYWQgdG8g
bGludXgtNi4xMC41Cj4gCj4gU2lnbmVkLW9mZi1ieTogSm9obiBLYWN1ciA8amthY3VyQHJlZGhh
dC5jb20+Cj4gLS0tCj4gwqBEb2NrZXJmaWxlwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfCAyICstCj4gwqBNYWtlZmlsZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDIgKy0KPiDCoHJ0ZXZhbC9tb2R1bGVzL2xvYWRz
L2tjb21waWxlLnB5IHwgNCArKy0tCj4gwqBydGV2YWwvcnRldmFsLmNvbmbCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHwgMiArLQoKV2FpdCwgdGhlcmUncyBib3RoIGFuIHJ0ZXZhbC5jb25m
IGFuZCBhbiBydGV2YWwvcnRldmFsLmNvbmY/CgoKPiDCoAo+IGRpZmYgLS1naXQgYS9ydGV2YWwv
bW9kdWxlcy9sb2Fkcy9rY29tcGlsZS5weQo+IGIvcnRldmFsL21vZHVsZXMvbG9hZHMva2NvbXBp
bGUucHkKPiBpbmRleCBmN2E5YzAwODQ4MDUuLjgwMTA2ODEyYWYwYSAxMDA2NDQKPiAtLS0gYS9y
dGV2YWwvbW9kdWxlcy9sb2Fkcy9rY29tcGlsZS5weQo+ICsrKyBiL3J0ZXZhbC9tb2R1bGVzL2xv
YWRzL2tjb21waWxlLnB5Cj4gQEAgLTIxLDcgKzIxLDcgQEAgZXhwYW5kX2NwdWxpc3QgPSBjcHVs
aXN0X3V0aWxzLmV4cGFuZF9jcHVsaXN0Cj4gwqBjb21wcmVzc19jcHVsaXN0ID0gY3B1bGlzdF91
dGlscy5jb21wcmVzc19jcHVsaXN0Cj4gwqBub25pc29sYXRlZF9jcHVsaXN0ID0gY3B1bGlzdF91
dGlscy5ub25pc29sYXRlZF9jcHVsaXN0Cj4gwqAKPiAtREVGQVVMVF9LRVJORUxfUFJFRklYID0g
ImxpbnV4LTYuNiIKPiArREVGQVVMVF9LRVJORUxfUFJFRklYID0gImxpbnV4LTYuMTAuNSIKPiDC
oAo+IMKgY2xhc3MgS0J1aWxkSm9iOgo+IMKgwqDCoMKgICcnJ0NsYXNzIHRvIG1hbmFnZSBhIGJ1
aWxkIGpvYiBib3VuZCB0byBhIHBhcnRpY3VsYXIgbm9kZScnJwo+IEBAIC0zMzQsNyArMzM0LDcg
QEAgY2xhc3MgS2NvbXBpbGUoQ29tbWFuZExpbmVMb2FkKToKPiDCoAo+IMKgZGVmIE1vZHVsZVBh
cmFtZXRlcnMoKToKPiDCoMKgwqDCoCByZXR1cm4geyJzb3VyY2UiOsKgwqAgeyJkZXNjciI6ICJT
b3VyY2UgdGFyIGJhbGwiLAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgImRlZmF1bHQiOiAibGludXgtNi42LjEudGFyLnh6IiwKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJkZWZhdWx0IjogImxpbnV4
LTYuMTAuNS50YXIueHoiLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICJtZXRhdmFyIjogIlRBUkJBTEwifSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgImpvYnNwZXJjb3JlIjogeyJkZXNjciI6ICJOdW1iZXIgb2Ygd29ya2luZyB0aHJlYWRz
IHBlcgo+IGNvcmUiLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICJkZWZhdWx0IjogMiwKPiBkaWZmIC0tZ2l0IGEvcnRldmFsL3J0ZXZh
bC5jb25mIGIvcnRldmFsL3J0ZXZhbC5jb25mCj4gaW5kZXggYTRhYWQzM2UyNjRmLi4wNjExYzAz
MWMyYTAgMTAwNjQ0Cj4gLS0tIGEvcnRldmFsL3J0ZXZhbC5jb25mCj4gKysrIGIvcnRldmFsL3J0
ZXZhbC5jb25mCj4gQEAgLTE4LDcgKzE4LDcgQEAgZGJlbmNoOsKgwqDCoCBleHRlcm5hbAo+IMKg
c3RyZXNzbmc6IG1vZHVsZQo+IMKgCj4gwqBba2NvbXBpbGVdCj4gLXNvdXJjZTogbGludXgtNi42
LjEueHoKPiArc291cmNlOiBsaW51eC02LjEwLjUueHoKCldoeSBkb2VzIHRoaXMgbm90IGhhdmUg
LnRhciBpbiB0aGUgbmFtZSwgd2hpbGUgYm90aCB0aGUgZGVmYXVsdCBhbmQgdGhlCmFjdHVhbCBm
aWxlbmFtZSBkbz8KCi1DcnlzdGFsCgo=

