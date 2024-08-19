Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DC115E96
	for <linux-rt-users@vger.kernel.org>; Mon, 19 Aug 2024 20:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724100864; cv=none; b=l6or2DuwfHc8Xdk6lYqecUJKD5LtpR86o4RLgfuAn/LZfhNCmD9Yamei3pwO3OynzacDHiTjIZUHgLZszPxQ33uqzu5/N7zAfRoKzb70KUQ1aAtHqfgeb1PmtOOXSmr+MRoShvjCnpqtxTv+4dXRb33pwqNxG+Vsz1Lx0nHrdbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724100864; c=relaxed/simple;
	bh=HvQYe8PQg/kEBQXzh1PYAwfORpg6uyJRL1lZt73cn5w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FTL/78cifghYp/xt/8GcBv/+Ki+wLsdwM5KTyf3A4EuiHoelM4edM+GnTD4vAsoKDajjvAeBYZWf1ipMe9/HRYRiDKYQPCMMJ07Wt78io2sqG/mtvwhce/R98nD4zPPxLCk0WiL2y78zAAugwDh+E8MOaVqXgIpDTMkB4mEGD94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=inUxFZrr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="inUxFZrr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724100861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HvQYe8PQg/kEBQXzh1PYAwfORpg6uyJRL1lZt73cn5w=;
	b=inUxFZrrxHzjlkvCS38iKlv5Gyf9Vs5TWSVoqzN/2PK6Gns8fqLgx1kFdVF4N7cfnqxFOD
	cAx1kd/fz9EyuUktAUf3/ZA+9NPVtkRP0CMu+Tk0tyO6C7K13B0A+qKYVRXsaKYW6YKk4K
	mrnvOUsslliurzHqqYANiFCAMkc/dqo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-3AEkAtnmO26M22sk_VnOpA-1; Mon,
 19 Aug 2024 16:54:18 -0400
X-MC-Unique: 3AEkAtnmO26M22sk_VnOpA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E3271955F2F;
	Mon, 19 Aug 2024 20:54:17 +0000 (UTC)
Received: from [10.2.16.120] (unknown [10.2.16.120])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9CB8F19560A3;
	Mon, 19 Aug 2024 20:54:15 +0000 (UTC)
Message-ID: <76d0ddcfd69e44c30d9cd73b3d10a63971d987f2.camel@redhat.com>
Subject: Re: [PATCH 3/3] rteval: Fix parsing in kcompile of the kernel to
 compile
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>, RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>, Tomas Glozar <tglozar@redhat.com>,
  Chris White <chwhite@redhat.com>, Anubhav Shelat <sanubhav1000@gmail.com>
Date: Mon, 19 Aug 2024 15:54:14 -0500
In-Reply-To: <20240818194216.299176-4-jkacur@redhat.com>
References: <20240818194216.299176-1-jkacur@redhat.com>
	 <20240818194216.299176-4-jkacur@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

T24gU3VuLCAyMDI0LTA4LTE4IGF0IDE1OjQyIC0wNDAwLCBKb2huIEthY3VyIHdyb3RlOgo+IFRo
aXMgcGF0Y2ggZG9lcyB0d28gdGhpbmdzLgo+IDEuIEl0IGFsbG93cyB5b3UgdG8gY3JlYXRlIHlv
dXIgb3duIGN1c3RvbWVyIGtlcm5lbCB3aXRoIGEgZGFzaCAtcnRldmFsCj4gwqDCoCBpbiB0aGUg
bmFtZSwgZWcsIGxpbnV4LTYuMTAuNS1ydGV2YWwKCnMvY3VzdG9tZXIvY3VzdG9tLwoKCj4gwqAK
PiDCoMKgwqDCoCBkZWYgX2ZpbmRfdGFyYmFsbChzZWxmKToKPiAtwqDCoMKgwqDCoMKgICMgSWYg
dGhlIHVzZXIgc3BlY2lmaWVzIHRoZSBmdWxsIGtlcm5lbCBuYW1lLCBjaGVjayBpZiBhdmFpbGFi
bGUKPiAtwqDCoMKgwqDCoMKgwqAgdGFyZmlsZSA9IG9zLnBhdGguam9pbihzZWxmLnNyY2Rpciwg
c2VsZi5fY2ZnLnNvdXJjZSkKPiAtwqDCoMKgwqDCoMKgwqAgaWYgb3MucGF0aC5leGlzdHModGFy
ZmlsZSk6Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHRhcmZpbGUKPiArwqDCoMKg
wqDCoMKgwqAgIiIiIEZpbmQgdGhlIHRhcmJhbGwgYW5kIHNlbGYuX2tlcm5lbF9wcmVmaXggIiIi
Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgIGlmICdyYycgaW4gc2VsZi5fY2ZnLnNvdXJjZToKPiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0YXJmaWxlX3ByZWZpeCA9IHJlLnNlYXJjaChyIlxkezEs
Mn1cLlxkezEsM31cLVthLQo+IHpdKlxkezEsMn0iLCBzZWxmLl9jZmcuc291cmNlKS5ncm91cCgw
KQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRhcmZpbGVfcHJlZml4ID0gcmUuc2VhcmNoKHIi
XGR7MSwyfVwuXGR7MSwzfVwtcmNcZHsxLDJ9IiwKPiBzZWxmLl9jZmcuc291cmNlKS5ncm91cCgw
KQo+ICvCoMKgwqDCoMKgwqDCoCBlbGlmICdydGV2YWwnIGluIHNlbGYuX2NmZy5zb3VyY2U6Cj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdGFyZmlsZV9wcmVmaXggPSByZS5zZWFyY2gociIoXGR7
MSwyfVwuXGR7MSwzfVwuXGR7MSwzfVwtCj4gcnRldmFsKXwoXGR7MSwyfVwuXGR7MSwzfVwtcnRl
dmFsKSIsIHNlbGYuX2NmZy5zb3VyY2UpLmdyb3VwKDApCj4gwqDCoMKgwqDCoMKgwqDCoCBlbHNl
Ogo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0YXJmaWxlX3ByZWZpeCA9Cj4gcmUuc2VhcmNo
KHIiKFxkezEsMn1cLlxkezEsM31cLlxkezEsM30pfChcZHsxLDJ9XC5cZHsxLDN9KSIsCj4gc2Vs
Zi5fY2ZnLnNvdXJjZSkuZ3JvdXAoMCkKPiDCoAo+ICvCoMKgwqDCoMKgwqDCoCAjIFNhdmUgdGhl
IGtlcm5lbCBwcmVmaXgKPiArwqDCoMKgwqDCoMKgwqAgc2VsZi5fa2VybmVsX3ByZWZpeCA9ICJs
aW51eC0iICsgdGFyZmlsZV9wcmVmaXgKPiArCj4gK8KgwqDCoMKgwqDCoMKgICMgSWYgdGhlIHVz
ZXIgc3BlY2lmaWVzIHRoZSBmdWxsIGtlcm5lbCBuYW1lLCBjaGVjayBpZiBhdmFpbGFibGUKPiAr
wqDCoMKgwqDCoMKgwqAgdGFyZmlsZSA9IG9zLnBhdGguam9pbihzZWxmLnNyY2Rpciwgc2VsZi5f
Y2ZnLnNvdXJjZSkKPiArwqDCoMKgwqDCoMKgwqAgaWYgb3MucGF0aC5leGlzdHModGFyZmlsZSk6
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHRhcmZpbGUKPiArCj4gwqDCoMKgwqDC
oMKgwqDCoCAjIGVpdGhlciBhIHRhci54eiBvciB0YXIuZ3ogbWlnaHQgZXhpc3QuIENoZWNrIGZv
ciBib3RoLgo+IMKgwqDCoMKgwqDCoMKgwqAgeHpfZmlsZSA9IG9zLnBhdGguam9pbihzZWxmLnNy
Y2RpciwibGludXgtIiArIHRhcmZpbGVfcHJlZml4ICsKPiAiLnRhci54eiIgKQo+IMKgwqDCoMKg
wqDCoMKgwqAgZ3pfZmlsZSA9IG9zLnBhdGguam9pbihzZWxmLnNyY2RpciwibGludXgtIiArIHRh
cmZpbGVfcHJlZml4ICsKPiAiLnRhci5neiIgKQo+IMKgwqDCoMKgwqDCoMKgwqAgaWYgb3MucGF0
aC5leGlzdHMoeHpfZmlsZSk6Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiB4el9m
aWxlCj4gLcKgwqDCoMKgwqDCoMKgIGVsaWYgb3MucGF0aC5leGlzdHMoZ3pfZmlsZSk6Cj4gK8Kg
wqDCoMKgwqDCoMKgIGlmIG9zLnBhdGguZXhpc3RzKGd6X2ZpbGUpOgo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCByZXR1cm4gZ3pfZmlsZQo+IMKgwqDCoMKgwqDCoMKgwqAgcmFpc2UgcnRldmFs
UnVudGltZUVycm9yKHNlbGYsIGYidGFyZmlsZSB7dGFyZmlsZX0gZG9lcyBub3QKPiBleGlzdCEi
KQoKV2h5IGRvIHdlIGhhdmUgYW55IG9mIHRoaXMgaW5zdGVhZCBvZiBqdXN0IGhhdmluZyB0aGUg
dXNlciBwb2ludCBhdCB0aGUKc3BlY2lmaWMgZmlsZSAod2hpY2ggSSBhc3N1bWUgaXMgbWFpbmx5
IG9mIGludGVyZXN0IGZvciB3b3JraW5nIGFyb3VuZApwcm9ibGVtcyBidWlsZGluZyB0aGUgZGVm
YXVsdCBvbmUpPwoKLUNyeXN0YWwKCg==

