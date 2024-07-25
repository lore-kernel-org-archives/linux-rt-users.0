Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D433B18028
	for <linux-rt-users@vger.kernel.org>; Thu, 25 Jul 2024 15:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721922809; cv=none; b=TgzkImu9ykvTbuahb/lccss5zQ8VNxT3IwYNze7ILnKVTCg3kuPL3s1kHk46Eni/5mWwusdiI0zG/XclTUKowRbjDe006n3Iiq5CTMy3b+9s9RyuD3BYGoI+FJfaj656aaNkK63pgSGLKW5fE+CuiSsN95WmawCaoXXIBg+3I7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721922809; c=relaxed/simple;
	bh=Nx9sWdkIxXalQE7qja09XBzf3yyorQdyf3d72meN7/w=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mXDm5oYYG6wHv1I4WboMD0ni6DIhZBTuAysSTCRQP9h1alScmEfi31s6ZtGxb/8jNZ7ZENozZFF23U4SoKx82WL5Ip8nTHd6/G70h6dwkHLjYw7FMUYjV+XeOiHiJ4xWEHNsuS9duUKATvIZzbE+P3WfPWPR6Pnm4jmCWdK8mWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Na/Ms29F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Na/Ms29F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721922806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GZePGBsWLEyCYA3BSPKvWpZbPMBx+DuyxesqUW7khPk=;
	b=Na/Ms29FrllK3LoFu8rRTRzeuuAatylRRTavicFVdut8X4vcz/hMe28cXJ/W9nzLsxSMyV
	wlrSubBCbJ+SChVFSQ+vkd8LyJHtHVwQfQzB2WqH1pXN4i2wjd4Dvhx338mt1zQmM36m1y
	oyMEM4QXYRs32QPcDJPLVvZ/+tdqqYA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-_XwIAbR6MFmZrFbjguufZA-1; Thu, 25 Jul 2024 11:53:25 -0400
X-MC-Unique: _XwIAbR6MFmZrFbjguufZA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7a1d8c45a90so89063785a.2
        for <linux-rt-users@vger.kernel.org>; Thu, 25 Jul 2024 08:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721922804; x=1722527604;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GZePGBsWLEyCYA3BSPKvWpZbPMBx+DuyxesqUW7khPk=;
        b=h9sAMX6S5lQYgSJVEOPQrHUHjIbfERC6BrxWGbn30kFUedQZ0nyhgfQjvRAD75eDxb
         esFFSBiCf1Gl6qyybyduQ9MXXnSEdUHJc8PbOlq2zfCyHeNJNel1qAgDsmVewLdTuBWJ
         O2Np9wIbbCoBHdqAER/zbYu3HRlzZH7iucMaGaJozYY+3g0gabRNgh0nnBzi0ChRENfw
         0bZG5YpuYD7ro8s6HDCi6Kz1b9AzaR0pCJooVbcB87KtZAKzqAElFyLjmpLiQPEz3qzS
         tkC2R2bLPs12iU1epvsCAsn/lLHX7YYbMVV1am+ypg6DCyFPqnfBJepOZpyWPTItxk0u
         zA+Q==
X-Gm-Message-State: AOJu0Yzlsoz3kcwIWO7+ZLGzKunkN6zu1+I8IKEadrvQaSoBaIhRe7dJ
	d3JAsqaUIoYXBtm4K8cGGwwpv7xHb6nhAAXpzopRHVdmJgcF5nZdXF5TkEm/JrOPN48s1Wf+JhQ
	AwH7KTUPYhfyKAn2t5m/tVxfq8zdLpKZJJMtglR9F4GmEDdTaCzKpDjO6uwtu5g+A
X-Received: by 2002:a05:620a:269b:b0:7a1:c426:d875 with SMTP id af79cd13be357-7a1d7e9b44emr308870885a.39.1721922804618;
        Thu, 25 Jul 2024 08:53:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMv88q5HfiJKpJCtS8qmLIufMdqiHMS0JTXS5CKxULX7Z9qbOpL7tybH0iAFnHUBdeSkDdtQ==
X-Received: by 2002:a05:620a:269b:b0:7a1:c426:d875 with SMTP id af79cd13be357-7a1d7e9b44emr308868785a.39.1721922804283;
        Thu, 25 Jul 2024 08:53:24 -0700 (PDT)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d7435582sm96695985a.85.2024.07.25.08.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 08:53:23 -0700 (PDT)
Date: Thu, 25 Jul 2024 11:53:22 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Anubhav Shelat <ashelat@redhat.com>
cc: linux-rt-users <linux-rt-users@vger.kernel.org>, kcarcia@redhat.com
Subject: Re: [PATCH v4] rteval: Added functionality to allow user to set the
 cstate of specified cpus when running rteval
In-Reply-To: <20240724191225.1722773-1-ashelat@redhat.com>
Message-ID: <2b23c4e1-9798-bc29-ff1a-4293777d4ae7@redhat.com>
References: <20240724191225.1722773-1-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 24 Jul 2024, Anubhav Shelat wrote:

> We would like to be able to set the idle states of CPUs while running
> rteval.
> 
> This patch adds the file cpupower.py and option '--idle-set' within
> rteval to use cpupower. The set idle state is applied to the cpulist
> given by '--measurement-cpulist'.
> 
> cpupower.py provides the infrastructure to interface and execute the cpupower
> command, and the options in rteval-cmd let the user specify the idle state
> to be set and the CPUs to set it on.
> 
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>

Hi Anubhav

Your patches are not applying, are you sure that you updated your local 
git repo to the latest before generating your patches?

Thanks

John Kacur

