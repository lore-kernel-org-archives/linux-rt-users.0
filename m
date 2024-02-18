Received: from mail-m92235.xmail.ntesmail.com (mail-m92235.xmail.ntesmail.com [103.126.92.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0A31DFC5
	for <linux-rt-users@vger.kernel.org>; Sun, 18 Feb 2024 23:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.126.92.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708298048; cv=none; b=fj1pXxT5nv0Q7/TqG2swBUwKCA5y1ZBvsA5U7FagnZoVLJIDE6QbF/wm4Gtw6dGRwSlQ/psigjnIbRigDO9zBHsde7AO7TemRl7aDW5ps9/Hn/8JjNOwKHfJoJXUQ21e0VywJtIfwquXyTU3AohmL0094bCvCPob5Qt+OVmlyUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708298048; c=relaxed/simple;
	bh=E8ay2kh/f5y4iYqdlYKzQyda0SBGWBNqE+cIG87qYb0=;
	h=Date:From:To:Subject:Mime-Version:Message-ID:Content-Type; b=OdswYcbppPLu2hAJ36l+IabHT3v4Sld5kNAyVFcS7SzMc7F1Tif51kF30vFD1R4G66XqBQk+pMlkkMAS/mU3vJ3KAOeIA8Qj0NLkv/YshEBfLs9pTSZxgMgFIO/CGh2FjWDsgc6FclyDmXF/qPB734hQayY7tvZdqasXGb0kEqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hirain.com; spf=pass smtp.mailfrom=hirain.com; dkim=pass (1024-bit key) header.d=hirain.com header.i=@hirain.com header.b=sEIlJBy0; arc=none smtp.client-ip=103.126.92.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hirain.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hirain.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hirain.com header.i=@hirain.com header.b="sEIlJBy0"
DKIM-Signature: a=rsa-sha256;
	b=sEIlJBy0bzCldttuWqrvhCQCvViXAsH9vADcn4vpcRhbd8c8+sHv439wsarUUgRBPKBmBptxlSEljaj/gXMIRlahEXk//S4xkqnU++sNlxwTpcZRxDt5oNkQXlYf7D05LEgbH+EvOXvy/hncLhEPjZYOmQdxuYsbdjRs0kzpfC4=;
	c=relaxed/relaxed; s=default; d=hirain.com; v=1;
	bh=E8ay2kh/f5y4iYqdlYKzQyda0SBGWBNqE+cIG87qYb0=;
	h=date:mime-version:subject:message-id:from;
Received: from pangaoAL (unknown [114.255.110.90])
	by smtp.qiye.163.com (Hmail) with ESMTPA id F1908460260
	for <linux-rt-users@vger.kernel.org>; Sun, 18 Feb 2024 19:26:56 +0800 (CST)
Date: Sun, 18 Feb 2024 19:26:56 +0800
From: "pan.gao@hirain.com" <pan.gao@hirain.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: linux preempt-rt_ full + interrupt +poll on kernel 5.4.247
X-Priority: 3
X-Has-Attach: no
X-Mailer: Foxmail 7.2.9.156[cn]
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <202402181926401806828@hirain.com>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFPTUtLTU9LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk0dGFYdHh0ZSRkYHx9DTx9VEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSk9VSU5OVUpKS1VCS1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1
	VKQktLWQY+
X-HM-Tid: 0a8dbbf8200303aekunmf1908460260
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OEk6Mio5NTMXTC4UFEoRPB82
	KgwaCkJVSlVKTEtDSU5OTUpMT0lIVTMWGhIXVQsaFVUcGhQ7ExIJGhIVVRgUFkVZV1kSC1lBWUpK
	T1VJTk5VSkpLVUJLWVdZCAFZQUpOQ0k3Bg++

SGVsbG/vvIxkZWFyOgrCoCDCoCDCoEkgaGF2ZXNvbWUgcHJvYmxlbXMgd2hlbiB1c2luZyBsaW51
eCBwcmVlbXB0LXJ0LWZ1bGwgbW9kZS4gQWZ0ZXIgdGhlIHJlYWwtdGltZSBwYXRjaCwgYWxsIGlu
dGVycnVwdHMgaGF2ZSBiZWVuIGZvcmNlZCB0byBiZSB0aHJlYWRlZCwgYW5kIHRoZSBzcGluX2xv
Y2sgdXNlZCBpbiB0aGUga2VybmVsIGhhcyBiZWVuIGNvbnZlcnRlZCB0byBhIG11dGV4LiBJIHdh
bnQgdXNlIGludGVycnVwdCB3YWtlIHVwKyBQT0xMIG1lY2hhbmlzbSBub3RpZmljYXRpb24gYW5k
IEkgdHVybiBvZmYgaW50ZXJydXB0IHRocmVhZGluZyBhdCB0aGUgc2FtZSB0aW1lLiBJbiB0aGlz
IGNhc2UsIEkgaGF2ZSBzb21lIHByb2JsZW1zLiBCZWNhdXNlIHNwaW5fbG9jayBpcyB1c2VkIGlu
IHdha2VfdXAsIEkgZm91bmQgdGhhdCB3ZSBoYXZlIHByb3ZpZGVkIHN3YWtlX3VwLCBidXQgdGhl
cmUgaXMgbm8gY29ycmVzcG9uZGluZyBmdW5jdGlvbiBpbnRlcmZhY2UgZm9yIHBvbGwuIEkgd291
bGQgbGlrZSB0byBrbm93IGlmIHN1Y2ggYW4gaW50ZXJmYWNlIGlzIG5vdCBwcm92aWRlZCBvciBp
cyB0aGlzIHVzYWdlIG5vdCByZWNvbW1lbmRlZD8gQW5kIHdoeT8KCgotLS0tLS0tLS0tLS0tLQpw
YW4uZ2FvQGhpcmFpbi5jb20=

