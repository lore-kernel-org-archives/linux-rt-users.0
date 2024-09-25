Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731BD1870
	for <linux-rt-users@vger.kernel.org>; Wed, 25 Sep 2024 17:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727286461; cv=none; b=Mlm4P22nZ0Ab/9mSs63z1AKrUZ2Wla76RxTi2LWbM1K+LBWojp6o4xn04+pLRnoTtugQNmrMBXkq//xL7pcj76ohw/F9MYyqDUXLjyi0ANqzzXLcCx4CazKZR63Xe+lqz/2ri0txH7+p/ZyfUKEh0BwzE97x94CfQjgz9+i2OLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727286461; c=relaxed/simple;
	bh=hw/suiJPaTZf7V0/TAT0o+KtuVJWIFXh95YPsgOXdZE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Qxa+fEeYob1CCb80cEMppPfUiyVbfzElzNgzq6NKLgzv6fuknS+44qhKyPVBkTaho6jFUuGwEcpA8F39bOeswUtIW81C1FZQK1VUyEXc3ZKOuWjVJi7QnS5XSyKL0/Hxziw4jtQLkBHBJ6X/6m17nPF4ByclLk8YJKuP0W8G9jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y2uTa+Yy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y2uTa+Yy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727286459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NQc3ucEvCcn7bpyaMoL2Pkd2DIEhAsnZ7+trbWt0oMA=;
	b=Y2uTa+YyANEplN+yXVWyrJIAt70CBf6tFUmZY/PIa4wHDha55FFcfJK81MsvcaKLHRhkwR
	RUnSQGRAQuCPIQR5/LuL1oOU/IuAajl/mDzs+Cl2G05JH5+BgwVaatrR13eIQyQZx+Y/Mc
	CV/Q+dJL1K6KcAk8uKkTMFtmX6SvS9s=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-DXd0a5jzM9qpcJo78P4-NQ-1; Wed, 25 Sep 2024 13:47:38 -0400
X-MC-Unique: DXd0a5jzM9qpcJo78P4-NQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7a9a6634b08so26709585a.0
        for <linux-rt-users@vger.kernel.org>; Wed, 25 Sep 2024 10:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727286457; x=1727891257;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NQc3ucEvCcn7bpyaMoL2Pkd2DIEhAsnZ7+trbWt0oMA=;
        b=cY/fn5eUgBx6auO/2xrnNgtjFbgUnyl1XAsnBQJEG7SMcf7N5V5PCqgGcNamrhuz+E
         Rgy0v6Quvxy8k4bIeaIPOn1CCIEbzhqfTVzjCiR1eY2ScrxRGgMDENJs2M8vt1byXp/X
         LgtJvHOqr4iGMbztTZz8hWnkrTWfG8aAwuW/YQA8j/kbSQO13P4MKz1hvvB7GPof/JHe
         kmVOa6V9omUwwWt3UOGUCjhMYS+uZHEv9kN/TzOdtgfV3gCPMenpv3WEBWu+/PB19M0I
         5Oi0hZZsIzY3vdgu4iRbXCy4ebdwKqtA6HStR1LBegDU2NbFG/MRPX2CacRVUeS3tDzX
         VNHA==
X-Forwarded-Encrypted: i=1; AJvYcCUq+KasqNJ5LIMm/wzec5P2OqLG1ga0GFQSSwy4/7H7p9IvO73xRbBVNRKXkM33dNUNuqVQx+D5qwM5vz47JQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi6JQc0K0hsclhgDfnpCcKHuiIE0stLGCoZr0NrJF4bY1K+Eo8
	ghmvMDJ5tj/oCR6CQ1FfRWg2ZJczd54b1eazGIe9CV+xylpTsGuYc+X5hIGAj1gK6j3PMt4Cy/T
	13lWXNkXA6FCLw0ZQtxcdl/6Tlva4DC5QPoTb0C2JW9n42TgE4Xpp8jDoZcyAsw3g
X-Received: by 2002:a05:620a:bc1:b0:79e:f9f4:3e99 with SMTP id af79cd13be357-7ae2c5f8937mr72890885a.1.1727286457424;
        Wed, 25 Sep 2024 10:47:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfh+/40uN1FhzXLi5WKzaz5n0/o4cYrisNe44sQM/CRHmJ65wyVV841+thUJmfqvfYSRMSkA==
X-Received: by 2002:a05:620a:bc1:b0:79e:f9f4:3e99 with SMTP id af79cd13be357-7ae2c5f8937mr72887285a.1.1727286457038;
        Wed, 25 Sep 2024 10:47:37 -0700 (PDT)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acde5cc7d3sm193397285a.81.2024.09.25.10.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 10:47:36 -0700 (PDT)
Date: Wed, 25 Sep 2024 13:47:35 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: "John B. Wyatt IV" <jwyatt@redhat.com>
cc: Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org, 
    kernel-rts-sst <kernel-rts-sst@redhat.com>, 
    "John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH] rt-tests: Add console_commands.json to gitignore
In-Reply-To: <20240923155317.43655-1-jwyatt@redhat.com>
Message-ID: <456065ea-31ff-8436-4a15-70c198218526@redhat.com>
References: <20240923155317.43655-1-jwyatt@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Mon, 23 Sep 2024, John B. Wyatt IV wrote:

> compile_commands.json is needed to use the LSP functionality in
> VSCode, Emacs, and Neovim. It is build specific so add it to the
> gitignore.
> 
> Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
> Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
> ---
>  .gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.gitignore b/.gitignore
> index 9d30878..1fa2677 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -47,5 +47,6 @@ rt-tests.spec
>  tags
>  TAGS
>  cscope.*
> +compile_commands.json
>  src/cyclictest/__pycache__/
>  __pycache__/
> -- 
> 2.46.0
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

