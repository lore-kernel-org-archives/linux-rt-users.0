Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B798159583
	for <linux-rt-users@vger.kernel.org>; Mon, 19 Aug 2024 20:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724100234; cv=none; b=dm2C+tZfXAvJThhWkEBF5LdzpMipPXIyHADyUh1lwOv1ayZ3fzBivXK6YtWzNo+z9aHjQTR3+A2A45lMsDaGUvTJzt43+gbVK4DQW/LMuEiHQTseF9zeQ3xsk7MVCKn/L5Dwus2YLLj4gIZcBkS/l2BBSuRHUHAGWauh5eBAF5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724100234; c=relaxed/simple;
	bh=cG+6WOS05oVmwm3BJ7MKG9XZU6JVyS1Q/EgKmpZsX4Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mCNSn6e0DtO/mQj8rjCcI6Y8rNKdkK8vfsaJCH5S4FCNkZtjUrYxTfTx+WR8TWCTSZ+0CKQVE/L9Fa426aGkO53DB12vXn4jvTrgonFCroJIdBy7AeU55Tbe7ykxPj5LtS3fqn5wPcSW/o7ygKBl9E2/Do8639f8hT0xkISx4Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a0hc45kN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a0hc45kN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724100231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cG+6WOS05oVmwm3BJ7MKG9XZU6JVyS1Q/EgKmpZsX4Q=;
	b=a0hc45kNQSPAo1z9uUbFzOpro+p/PaQ0/n+werIV5nkSkMqZs10eE3rhe2S9oKIR+Q022y
	pvxAyqgeKkpq32Q3jb8dfmm6cJ0kcRkkHvqzX0PYeWRnJzFppE/seBSj9f6FDlDKWzfy1I
	D7HvDkWvDZdjkY6NZ/Knq5HCQTopICU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-142-I4AjKecDM-6IbGT8mc7FGQ-1; Mon,
 19 Aug 2024 16:43:47 -0400
X-MC-Unique: I4AjKecDM-6IbGT8mc7FGQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 77ACD1955F3F;
	Mon, 19 Aug 2024 20:43:45 +0000 (UTC)
Received: from [10.2.16.120] (unknown [10.2.16.120])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ACE5C19373D7;
	Mon, 19 Aug 2024 20:43:43 +0000 (UTC)
Message-ID: <247666ce2ef848b8bc336710facf25e91dd1c357.camel@redhat.com>
Subject: Re: [PATCH 2/3] rteval: Upgrade load kernel to linux-6.10.5
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>, RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>, Tomas Glozar <tglozar@redhat.com>,
  Chris White <chwhite@redhat.com>, Anubhav Shelat <sanubhav1000@gmail.com>
Date: Mon, 19 Aug 2024 15:43:42 -0500
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

T24gU3VuLCAyMDI0LTA4LTE4IGF0IDE1OjQyIC0wNDAwLCBKb2huIEthY3VyIHdyb3RlOgo+IFRo
ZSBvbGRlciBrZXJuZWwgZmFpbHMgdG8gY29tcGlsZSBvbiBuZXdlciB0b29sIGNoYWlucywgc28g
dXBncmFkZQo+IHRoZSBrZXJuZWwgdGhhdCBrY29tcGlsZSBjb21waWxlcyBhcyBhIGxvYWQgdG8g
bGludXgtNi4xMC41Cj4gCj4gU2lnbmVkLW9mZi1ieTogSm9obiBLYWN1ciA8amthY3VyQHJlZGhh
dC5jb20+Cj4gLS0tCj4gwqBEb2NrZXJmaWxlwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfCAyICstCj4gwqBNYWtlZmlsZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDIgKy0KPiDCoHJ0ZXZhbC9tb2R1bGVzL2xvYWRz
L2tjb21waWxlLnB5IHwgNCArKy0tCj4gwqBydGV2YWwvcnRldmFsLmNvbmbCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHwgMiArLQo+IMKgNCBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMo
KyksIDUgZGVsZXRpb25zKC0pCgpTaG91bGQgd2UgYWRkIGEgbWFrZSB0YXJnZXQgdG8gZmV0Y2gg
dGhlIHRhcmJhbGwgaWYgaXQncyBub3QgdGhlcmUsIHJhdGhlcgp0aGFuIG1ha2UgdGhlIHVzZXIg
bG9vayB1cCB0aGUgdXJsIHRvIGZldGNoIGZyb20gYW5kIGZpZ3VyZSBvdXQgd2hlcmUgdG8Kc3Rp
Y2sgaXQ/CgotQ3J5c3RhbAoK

