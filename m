Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC0244C93
	for <linux-rt-users@vger.kernel.org>; Mon, 19 Feb 2024 17:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708364001; cv=none; b=GCp807ZB7/3tbLYOATeJDNpp9GoX+txd79819HQzBfN0rCufy2CjQj4ShLDhTF3iCg7QmURMio/5+zdkVxXKdNn8+mRDiNSWs1JkDgZ41/OkgnvdhPokiQArRqNFmVJbVlY5E8qHOm6luppHBIgIx4aJg7TRZb/xNCLPx1cenXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708364001; c=relaxed/simple;
	bh=6avWnawr2UKbNt3LnY1oNnBulNS03ZSo4bYwpqCzFXk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UtLEmlZxRZG47ei8tmGiE5TcdSiVMIB3P8NqcNuve1YCHAU/Rvmxczvhd59BRkxtWTIHE0362cMyLWoC4N643homojR9WDCOG6MvVrhItGDnGOd7UN95ILpBQucfeQa1gvtafkvbRLD2xo+0GC/vRi2aNORUuG4BKIUAly+2Ia8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X33OWUes; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X33OWUes"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708363998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=y70x1lk7CC3AaVnNjq3BizuyfG0wau/9LXBpqiTefe8=;
	b=X33OWUeszH9ppZs8ZPJBJ5oduvgdA1gNFrAO2lpZi962tcbABg0/OG1ypcqHxD4oKDOYT2
	cKazzqxQEZiWbDyXLljCOvxhePfHtXu5aJl9XE7I+QILLzkQoDJLHp6C+x9wn4I89Trvzy
	Fjy0JEv6e0WPvXrfAHdrzChp3uqeR6w=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-FE6T6dQzNZaRjRQ2zFZzIQ-1; Mon, 19 Feb 2024 12:33:16 -0500
X-MC-Unique: FE6T6dQzNZaRjRQ2zFZzIQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-785d863287cso434360185a.3
        for <linux-rt-users@vger.kernel.org>; Mon, 19 Feb 2024 09:33:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708363996; x=1708968796;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y70x1lk7CC3AaVnNjq3BizuyfG0wau/9LXBpqiTefe8=;
        b=c1Tj/w4vmjML4UYB+PztGxPJ4hx6eFtx2XwPiITpHgGV2SwEO4w8HyQ/I3flwfYQEq
         fUpadBYpcRJkf/8HR+He0oSQ3Sq3/UYj0VkUOOf3I01Uvo3dS9+1hYxz8MJEzmfeSbJG
         +nzmmY2gJNVFCUjoiCMpSiQWul8SJUVCGOsHWWRqRskCLi4hC6arnEPn02nxn4WnRDIm
         xjgyT6jgWDp/QMb7y6L3GJMcsjubWr84eBGm445ikiHW8hvs+6rvfUhx+aYZ8ODgLXZS
         9wtJzrpVOYjt5LPkjEStAZa4jyth1V3nsP3EfsDwgREvV02y5esbCR5cimkKDEaaXD5T
         EXlg==
X-Forwarded-Encrypted: i=1; AJvYcCW39BMkg7Au2e64bOD1LCRHMAlNU0G5KGjTm8St8Kaow2snyQ+FkcF3fqJqdq3inDu4/LHg5V/42GiTW9oH2YK4J93/GudSn3HaWzFq8Rc=
X-Gm-Message-State: AOJu0Ywo+TebyxCrQFGeY8OJjMS1TCeoyTOeyOHMrXfrbPC0qm4/Yn+Z
	wRPzrwCPlyGA6+eBJlJ4SShnM+Z3qwSWJfutLsRbzfeD3xaalIbgtvuIxBGa44zLmf0xON9Nva0
	4NhZjYb+t3PAYJ9MODLCeGNFkouEjZcjQ78sV5/bjCogwg7t3s8GWrZ2owG2H7jk7
X-Received: by 2002:ae9:c30a:0:b0:787:6e99:a889 with SMTP id n10-20020ae9c30a000000b007876e99a889mr2048066qkg.37.1708363996012;
        Mon, 19 Feb 2024 09:33:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFBQjY+bgONGiwJ1rR4f9gvvW0U1G0AhkGdUJGBg6+TbNfHWaPDDjFL9uuKTQRsoigx6HeNA==
X-Received: by 2002:ae9:c30a:0:b0:787:6e99:a889 with SMTP id n10-20020ae9c30a000000b007876e99a889mr2048046qkg.37.1708363995737;
        Mon, 19 Feb 2024 09:33:15 -0800 (PST)
Received: from thinkpad2021 ([71.217.33.204])
        by smtp.gmail.com with ESMTPSA id i1-20020a05620a404100b00785d8a6d019sm2654149qko.12.2024.02.19.09.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 09:33:15 -0800 (PST)
Date: Mon, 19 Feb 2024 12:33:12 -0500
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, Clark Williams <williams@redhat.com>,
	Juri Lelli <jlelli@redhat.com>, Derek Barbosa <debarbos@redhat.com>,
	Bruno Goncalves <bgoncalv@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Automating console_blast.sh
Message-ID: <ZdOQ2KzOIgYc8Ber@thinkpad2021>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello John,

I am investigating if we can automate, and, possibly add console_blash.sh
[1] to our test suite here at Red Hat.

At Red Hat we use SSH to manage our test boxes. On an off-list email
you wrote that 'Only the UART should be used as a console'. I took
this as no ssh session should be used from the boot up until the crash,
but I should have confirmed this. Is this correct?

The license for our test suite is GPL v3 [2]. May we have your permission to
license it under that or permissive?

Adding Bruno @ CKI to CC. 

[1] https://lore.kernel.org/linux-rt-users/ZcQjxa4UA6hzXHnU@thinkpad2021/

[2] https://gitlab.com/redhat/centos-stream/tests/kernel/kernel-tests/-/tree/main/rt-tests

Sincerely
John Wyatt

