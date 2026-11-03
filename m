Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728524;
	b=4YaJhIEozfHVSfYRqSVREP2MD2DV6642Ibp7RwSSvaSeQpAyUQLkgLFFOhN/alEe/gsp
	 UM57e2VrJswCc+YSyT7XGpTO4+KMUhGLcD3Nqcd761dKOs3j8zjZP2qxsDUnmkeOY1LFF
	 AW2EolFajpAwHJAJue/NZYYy7xuG9QHHKu0neTE4P2zSucgVYlv21DdB2iAZ+AllyhSe0
	 bvyvXCdj0XwQZPSqrz/wlMsfLvXp9TnBY8gZC1TCMYoytNKp0yvB6W0jfA7owofVDWxVz
	 GCamiyTV9KKgFImv0e0RyTfRK8Xp1lRSbgjkG8TUwW+UZAfE+3FdkOc+AxhcmBvNe+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728524;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=8wWRnO45gNbOxksG+IRchu1UIqHpeVwxIrzSBv3SSCA=;
	b=03KwOXLWkWDwELP9JJq8gc/mvBA2SDd8jAS/zwc6lAjg2jYuQt2JF5A9cK+63f2LjCS0
	 B8limjUw582794bGAx0H71JNENXQhse4Kl8DKUDahvqZqJMtu7w0fH5V2sWQ6nulTIG+P
	 4lZYJQiaowsLtr4mY+NDLdANYCYzCQ+r4tClFvX0fVn4yTU0WM1oteaazLZcBn/s0K9Ct
	 VdRmu6Vm10QY8CfwSxBFuWvMJRBUt4IAUVZmuUw6d74ezlyuQzw92oFayW/aWfGsUIiro
	 9lxMuzSMNjxXEiKLqyC2AhYjOY4+Dxn7E7874g2Tv+uCOzkSld20T8OYx+pFnU8BfBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=redhat.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d49Qa7Ea;
	arc=none smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E05606A32E
	for <linux-rt-users@vger.kernel.org>; Tue,  3 Nov 2026 17:55:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25E05606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d49Qa7Ea
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8b06c0794cfso41668487b3.0
        for <linux-rt-users@vger.kernel.org>; Tue, 03 Nov 2026 09:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793728523; x=1794333323; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8wWRnO45gNbOxksG+IRchu1UIqHpeVwxIrzSBv3SSCA=;
        b=d49Qa7Ea4A6pFYn3//gGqXjYIU0ZK2sZwXk35NFwUzx9joMQ/a/6gRLoZ31Q0I9M0I
         pS0glc+Q2AE1taiOlDHDKoK+5TJBUKVcn9ekc994XdGORItGLeJSivOb1ap0GscAyyHL
         cWvn3+g/Rc7tSeadXS4PN/TEt/pL0Fh+iSObrwHevj7+OuasQZKcjReMxLMb9JJWdba8
         sPrrePGoHh2l7s6SlfdhYBhAAExk9XcbvLX1JG9+v0Nh+DdAwnFpK0CTopIZq9TxiVPC
         bh/sdRxh671jea82N1UBaNR5g9haZfdXYJbZpXy8wfdZeCy7tqu3uiFGHemvp/ZCGzkO
         owtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793728523; x=1794333323;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8wWRnO45gNbOxksG+IRchu1UIqHpeVwxIrzSBv3SSCA=;
        b=WXGC3AHDCGnNZkRT6/58OD6bF1+pwE83oQffGFt8+Wk44lRDzTnlktg+ude5vfX30+
         GbsjfCPz/9/RlSFL36n75tdSO7LccF4gdEutCJ7SOtHhUgUhXoT9xGjkEboW/wY+YbDD
         DdF7z2yfIP4SgkCMxYL7ggoywC5Y790v5hDbsTxnti8GRSY8jgP5aHfkGOw5fVt6E04D
         NeJBi9mQiviYkp7RtVn0LIzMf2T91m7zA/dufz2hGcE4vyruwYzUx3MCPSdqmHU6rLg6
         wPLoIGsmBHDB/IhI8SZZe1qKguZ4JlpPJoSNpK73dNH3LWJ60uebsbtpjG/pXfGk/yKH
         QtXw==
X-Gm-Message-State: APuU4Z86kTVfPyYW2BknQwG0e1t7Wnf3467KwYTvDvEt/R0pqVrNunBc
	2oWD56517yjmQTTXfjhzWujZftEw9ctpFMstbhxnd+/cC+hBXeRjrgI5
X-Gm-Gg: AYBFou2YFRzdqKo/ebkimCRefWkNC/RxOcWJK35lzqGii5LTDQcRICsmE6q8LUC6XOc
	6fPsMfMHOP3SOpun1NCiGETSxSK1iEr8xpGg8+fXFKMARvv0YsrTRa/sa1nwt/xjuyGnOejFLte
	oWjbg5h1ecMLSSOxRvtpSH0FWnq9Oc5vc0QO/GmF1p8FGcTjKsw3SZHbenTe9/+AL42vFQxIizW
	xWs5xnoY80P09Ja6Y8DYLwq/nOUrqn9mPFQtCDQtyijHyuzIVF1bp2iOu+WkYdvBmAXMnGYPpVR
	KRk1CU67c/KDEnxxj05gUZkMqOyGmRjfVKUxRbIF+Cr+V+muICzUI6lXzKqDhe3laxT4PrwBdwn
	FjT4qDlE5gFFmx3C1Cjg1g5bvTcOS+4IuzaN5/qLF2pu8u8Ha3Q7pG3VdYlHKYcXSB3kFA8kGbv
	pYE6SWjKz1kPv/uwWabjDoWUPmLJ9RxXF5d1xx3hGD+CFAcH36d9azDzjjfQ4QQ249feIceqHXz
	TjyPeOalAqbs4rb4O2oirPrvvh94bduFLrb9UT8ElND7ySI746ayVJRJyYFyRSLOtGTsJYi+Dec
	lyCrmDHsEmKqPrG1lSCvhbOBhfrHNZuKXebzm0yQs4CBEtYIXlM4ZWGQPmu5PqMB2eaSHXrVfDZ
	3XLls2j53tDO3xP2hA/AgDt4sa4kS8yEQ0Sk3rTd14BsalVA09cPV2YQKJVKgBCqV1TXs2Y+4
X-Received: by 2002:a05:690c:34c9:b0:8b0:ad5b:d466 with SMTP id 00721157ae682-8b2b66f8f31mr103345327b3.25.1793728523149;
        Tue, 03 Nov 2026 09:55:23 -0800 (PST)
Received: from fionn.home (bras-base-toroon01zb3-grc-09-70-50-116-123.dsl.bell.ca. [70.50.116.123])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b30997aa84sm1700707b3.29.2026.11.03.09.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 09:55:22 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: Sana Sharma <sansshar@redhat.com>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v1] rteval: Added integration tests multi stressor support in stress-ng
Date: Tue,  3 Nov 2026 12:55:16 -0500
Message-ID: <20261103175517.107723-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <auSgczD-qWxJhBbC@fedora>
References: <auSgczD-qWxJhBbC@fedora>
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 30 Oct 2026 at 09:49:39 -0400, Sana Sharma wrote:
> [PATCH v1] rteval: Added integration tests multi stressor support in stress-ng

Thanks for the patch Sana. Two fixes for a v2, and then a request for a
follow-up patch.

Fixes for this patch:

1. Don't rely on the 60s default duration. These tests only check the
   stress-ng command line that rteval builds, which does not depend on run
   length, so pass a short explicit -d. I verified -d 5 runs cleanly
   (exit 0, command logged); even -d 1 worked, but 5 leaves a little
   margin. As written, each run-based test takes the full 60 seconds.

2. Don't depend on the default measurement module. With no
   --measurement-module the tests default to timerlat/rtla; on a machine
   that only has cyclictest the run exits non-zero and the
   "returncode == 0" asserts fail. Pass --measurement-module explicitly
   (cyclictest is a safe choice for a test), or otherwise guarantee a
   measurement tool is present.

Follow-up patch (separate from the v2 above):

The happy paths are well covered, but I'd like a follow-up patch adding
negative / corner-case coverage. These are cheap to write as rootless
unit tests - like the existing TestWorkloadPrepareCpuset and the
validate_stressors tests - rather than as more full runs:

  - partial-invalid list, e.g. cpu,bogus -> ValueError naming only 'bogus'
  - multiple invalid, e.g. bogus,fake -> both listed
  - empty / trailing comma / bare comma ("cpu,", "", ",") - today these
    raise with an ugly message ("Invalid stress-ng stressors: ."); filter
    empties, give a clear message, and test it
  - case sensitivity (CPU) - confirm it is intentionally rejected
  - both --stressng-stressor and --stressng-stressors together - test that
    the multi form (--stressng-stressors) wins
  - neither flag -> module is skipped (_donotrun)
  - duplicates, e.g. cpu,cpu -> today this builds "--cpu 0 --cpu 0";
    decide whether to de-duplicate or warn, then test it
  - non-numeric / negative --stressng-workers -> either validate it, or
    document that it is passed straight through to stress-ng

Separately (and this one predates your series, so definitely its own
patch): get_valid_stressors() currently sys.exit(1)s when stress-ng is
missing or the query fails, and TestGetValidStressors locks that in. That
is heavy-handed for a load module and is why these tests can't run where
stress-ng is absent. It would be nicer to return [] and have the
validators pass names through (let stress-ng report bad ones), updating
the two existing tests to match - but that is a cleanup of existing code,
not something to pile onto this series.

No need to fold all of that into the v2 - a separate patch on top is fine.

John
