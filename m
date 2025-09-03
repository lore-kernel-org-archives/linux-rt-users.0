Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254CF1D54D8
	for <linux-rt-users@vger.kernel.org>; Wed,  3 Sep 2025 01:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756861614; cv=none; b=avYPhu5rfynp3Z2hkl0osbgcFpLZ8UuQ03d8RrQWaw9dkdzFh6Vwpw76lT6PuMbwMQ8TU6bgFUgrJSF6tN5Pj6s4Gl8H5qLAIqAd4nN2S6Q8AjgV2tkwFQ4h8bharVsu4DDZYv2rT6zBQVr+PcEZGI3WkexPcbnHA9QPiAu+nLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756861614; c=relaxed/simple;
	bh=mUhrPt+ooiUPxNnIz9UEcZj0YdIIDFA9/ZETvtcoKPg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cL38JrV6hK7pixdCMCKAeV4Q5hH4WiCX7Un5/Gj2mxiSP/IQgXALoMExNma8fQbxQqrTChi1WbO6pCUDCrYfa6+BrA+bWcJUpDSq3X4NpHvwOVMXsjfWe1+m5sc3kyNPlrGCtXHdG3tqDbRVS/On9lFymw1xxPURTcrRSlmAvlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HbFUNtxV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HbFUNtxV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756861612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pd04II+gtAp6QJKNc4+oIabvQjLWvmjk9px/GSFu11Q=;
	b=HbFUNtxVVkhJVQE5tCZepto1qk5WRDD+l0w//nwq/0p7ZEX7B5INpHa4ccDhrd+VGwMMWP
	cnCCOqQsjGdTd5qS4VS8TPkO44A4hwRW8M7Lo6jUQv4n2ffmSXkOajW/NeccmrtNuyebhW
	fUN33SN5aVr27SKnQsb2yl89lxnzCIo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-r3xZbnWzM3KxMexNwzuVtQ-1; Tue, 02 Sep 2025 21:06:50 -0400
X-MC-Unique: r3xZbnWzM3KxMexNwzuVtQ-1
X-Mimecast-MFC-AGG-ID: r3xZbnWzM3KxMexNwzuVtQ_1756861610
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70d7c7e972eso119300956d6.3
        for <linux-rt-users@vger.kernel.org>; Tue, 02 Sep 2025 18:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756861610; x=1757466410;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pd04II+gtAp6QJKNc4+oIabvQjLWvmjk9px/GSFu11Q=;
        b=ssL3A02B8NFbg5W6Hb1njJjk5w2ZnIrnLGoXmt4aBm5HhN/bqER6o3hDY1+7FZuSl3
         8oSyT7d1BPHGRR+50UF6HHCehbz1m61qBPxnmN/SNwwIKH6PtlkbE5KmMxEwsPHprAVJ
         fxxyK53nAjFLGlr7jQnvzH+dgtl1t8/CZa1hJvJ/tdoi1kM4AFrnVRv5QSK2zq5fswrf
         zcMgKUpibNIaE0X/F0LbPITM5Wa85LAAqKLtkUKs7lRNkIrsX7+UM2SlPfBNAjD7p+St
         yfhpli02QKW0mKOj86XcCiCbn+z8VdqUgpxA4SHrkgdxKxhaiOBbTeBRLIBxKg/XwpTt
         GKLg==
X-Gm-Message-State: AOJu0Yy9YDIjUjug+p+GMaCLKEu/+ZMD6JnfG3sdg8rWW2208s47hbO5
	6I9zCmXg/WDMpFblZD/+dUM0Z6HWOq1C7OrrmkcD9ui5Meaf5axtBzBku1BwcZ+KeLiC+MtOWPW
	cRT5a+nADLpLo+HwbbXdF4zw4puTzlLfovkBA2/GmtBP5M+HzmpQaTQoBQwrl4k6LNXmk
X-Gm-Gg: ASbGncuiaEEaagqpuBY/IM/ylb6mJPRDRixDyidrMurCEDAewKKjE7knn2Kxv65onVx
	zur9xoD5gbpZaEcbtLA1b3AyFpgF5mVqk2raX1kJezDCFN3OKBUnAZbMyZ83jJVNi9WU9TzNzMz
	tARjWhu7WnLeqpdd0WqtecHWHuYLoNKKDduo7ZvuCIn8CjYcjtke9dt30dLL6ttBhcgO+KTAzhj
	LtNhxNPImVSTq+e+bZ/uo5+nkuPlAtYbYKRQ0qyOoq/+YK7X95qaQmiigSsOiVnhAqN0m4rOuuF
	c5q54u/AxA0xAodGWoIy1JgL2bg5wt+pVN29PA==
X-Received: by 2002:a05:6214:240c:b0:70d:6de2:50d3 with SMTP id 6a1803df08f44-70fac97a438mr153662806d6.64.1756861610130;
        Tue, 02 Sep 2025 18:06:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzee57nHzBtAsn0nJq/EMv89+QEsCTtKjNIKDHBC6it9slLastT1A1NPyiBfIPVXmTZLiQsg==
X-Received: by 2002:a05:6214:240c:b0:70d:6de2:50d3 with SMTP id 6a1803df08f44-70fac97a438mr153662666d6.64.1756861609682;
        Tue, 02 Sep 2025 18:06:49 -0700 (PDT)
Received: from thinkpad2024 ([71.217.50.216])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ac16de47sm20920266d6.15.2025.09.02.18.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 18:06:49 -0700 (PDT)
Date: Tue, 2 Sep 2025 21:06:47 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Clark Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Cc: linux-rt-users@vger.kernel.org,
	kernel-rts-sst <kernel-rts-sst@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: RFC: Replacing rtctl style profile files with JSON
Message-ID: <aLeUp2F2sZaamoOu@thinkpad2024>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello linux-rt-users,

This email could also be titled: "Does anyone use profile saving and loading in Tuna?" :-)

Internally an issue came up that pointed out saving a profile printed a message about rtctl and how 'save' and 'apply' were ambiguous. The same profile could not be loaded without errors. I was able to reproduce similar errors by loading the example.conf file included in the Tuna source code. It 'errored' out with warnings ‘Error File contains no section headers’.

The naming for these files is also inconsistent in tuna: the gui calls the files profiles, tuna save calls them ‘kthreads sched tunables’, the ‘tuna apply’ has error messages calling them config files.

I propose cleaning up and replacing the rtctl style format with JSON files or removing the profile saving and resuming completely from tuna. The older ‘tuna apply’ loading code will be depreciated and kept for a while so users can have time to migrate.

Tuna requires root access to set profile settings. A barely used parser is a security issue. The load parser also requires a bit of a rework as it currently treats both errors and warnings the same way. See checkConfigFile and loadTuna. [1] rtctl has not been maintained in over a decade and not included in major distributions. I see no point in making sure files generated by Tuna work with rtctl or if they even work now (or if I can even compile rtctl these days). These arguments justify replacing, or removing, the profile functionality.

The gui has a nice interface for managing profiles, the values in the profile, and even correcting issues in a load profile that ‘tuna apply’ does not do (loadTuna is not used). I can imagine users may want to use this to test and tune their systems.

It has a few bugs too: if you create a new profile from the gui, the tab to actually set values disappears. The buttons may not respond properly. It even froze while I was trying to screen share.

'save' and 'apply' subcommands should also be renamed to 'save_profile' and 'load_profile'.

Mentions of rtctl should be removed except for a comment that Tuna was intended to replace rtctl in the manpage.

JSON is suggested because the two built in choices for Python are JSON or XML. I would like to avoid adding an external dependency on another library. JSON is a widely used format that gets test coverage with cpython. XML is more complicated and less often used these days.

Please sound off. Are there users that still use profile saving and resuming? How do you use it? Do you use the command line or the gui? If you use profiles, are you willing to test the new code?

[1] https://git.kernel.org/pub/scm/utils/tuna/tuna.git/tree/tuna/config.py#n394

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat

