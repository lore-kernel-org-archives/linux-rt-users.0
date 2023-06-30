Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEE8EB64DA
	for <linux-rt-users@archiver.kernel.org>; Fri, 30 Jun 2023 15:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjF3PyU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 30 Jun 2023 11:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbjF3PyJ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 30 Jun 2023 11:54:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720943ABF
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Jun 2023 08:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688140397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xhwVN//7isT3cwGPB0qJinGA9mLXOP6jXyxAQMUPGkA=;
        b=DVUQUktUd9J/TpZ+foRGgiFVXpKZ8bpwXIz7ZZrATWZC/t5aG0rBX85/+pQocs+E0uxhzN
        pHf7sFNvJPWJqiVB5+erRYA0bPiaaUhfaYjFgYKXynkAH+sLTPAkA+6G62jOJn2C1EO7Hv
        L/mLVmAHaENSBIYXba1omCYJQGl1Fks=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-5NYeDragM2eeCEUA05QzMA-1; Fri, 30 Jun 2023 11:53:15 -0400
X-MC-Unique: 5NYeDragM2eeCEUA05QzMA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7624ca834b5so238366185a.0
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Jun 2023 08:53:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688140395; x=1690732395;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xhwVN//7isT3cwGPB0qJinGA9mLXOP6jXyxAQMUPGkA=;
        b=R+ZuAUrbGdCNBHyZDS7naJ1P7V4yyIJozXxyq0SYHRn7W1wGL4KrhjePmo96Vo02rO
         JHWw0zHDnoq/18zO1eFcOpcOyBWLXIlxVNJcAjm0t+wFs0YvMlqyTvSUvZ4PoKiK6TCV
         3RpJgJP5NldQwD2hj5AOj6p25BpLSwvi1lzt11QJ3ZinuBw/wDxnKbZz2QdzZ7Fc3ZZc
         TkMxiN44WMkyrAJaz4rsCswhbPd+0/zbdbQ5XYl4DVyK6xXTdW9edTqKrE1oWdBt5nLs
         VIn4OcigyC9S862PODdT8mnPfIVeMwkF+jK0gTi2Og+Zed9PyGzMGjLfDQLHsmnh4AFz
         SVZA==
X-Gm-Message-State: ABy/qLaOWxTTOQJaxaJrjLyoeDoGT6JskfoM1fmsYgc0j0eNCD9ml8rQ
        /xUVaojyITRVgWXOGaE/O90EzaVhIZxmabqSwyaxgaQ6YvKd4VoJS9V/KLlVKamcwUFPD+33YGk
        pq80Ql7XIMD7bErP/va2BEyRGQYts5oEvIsI=
X-Received: by 2002:a05:620a:2a57:b0:765:7957:1aff with SMTP id q23-20020a05620a2a5700b0076579571affmr3284656qkp.74.1688140395112;
        Fri, 30 Jun 2023 08:53:15 -0700 (PDT)
X-Google-Smtp-Source: APBJJlESaRY4CL/XAOENdZPrksN0/Wb/p9Kn8UK7PfW0gjS4824qbgmKw9WEZaluIz9gG8vCQ6U6OA==
X-Received: by 2002:a05:620a:2a57:b0:765:7957:1aff with SMTP id q23-20020a05620a2a5700b0076579571affmr3284645qkp.74.1688140394879;
        Fri, 30 Jun 2023 08:53:14 -0700 (PDT)
Received: from fionn ([184.147.141.56])
        by smtp.gmail.com with ESMTPSA id d2-20020a05620a158200b0075b2af4a076sm7181561qkk.16.2023.06.30.08.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 08:53:14 -0700 (PDT)
Date:   Fri, 30 Jun 2023 11:52:53 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Anubhav Shelat <ashelat@redhat.com>
cc:     linux-rt-users@vger.kernel.org, kcarcia@redhat.com
Subject: Re: [PATCH v2] Fixed bug in kcompile where run would fail if
 kcompile-source version had the form x.y instead of x.y.z
In-Reply-To: <20230629204538.888970-1-ashelat@redhat.com>
Message-ID: <2e5136a-2bcf-bf15-35ab-f76d61b92013@redhat.com>
References: <20230629204538.888970-1-ashelat@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 29 Jun 2023, Anubhav Shelat wrote:

> Fixed bug in kcompile where run would fail if kcompile-source version
> had the form x.y instead of x.y.z
> 
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> ---
>  rteval/modules/loads/kcompile.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
> index 35ee5cbbb52d..a1f5614dbd3b 100644
> --- a/rteval/modules/loads/kcompile.py
> +++ b/rteval/modules/loads/kcompile.py
> @@ -175,7 +175,7 @@ class Kcompile(CommandLineLoad):
>          if 'rc' in self._cfg.source:
>              tarfile_prefix = re.search(r"\d{1,2}\.\d{1,3}\-[a-z]*\d{1,2}", self._cfg.source).group(0)
>          else:
> -            tarfile_prefix = re.search(r"\d{1,2}\.\d{1,3}\.*\d{1,2}", self._cfg.source).group(0)
> +            tarfile_prefix = re.search(r"\d{1,2}\.\d{1,3}\.*\d{1,2}" + "|" + r"\d{1,2}\.\d{1,3}", self._cfg.source).group(0)
>  
>          # either a tar.xz or tar.gz might exist. Check for both.
>          xz_file = os.path.join(self.srcdir,"linux-" + tarfile_prefix + ".tar.xz" )
> @@ -193,7 +193,7 @@ class Kcompile(CommandLineLoad):
>          # find our source tarball
>          if self._cfg.source:
>              self.source = self._find_tarball()
> -            kernel_prefix = re.search(r"linux-\d{1,2}\.\d{1,3}\.*\d{1,2}", self.source).group(0)
> +            kernel_prefix = re.search(r"linux-\d{1,2}\.\d{1,3}\.*\d{1,2}" + "|" + r"linux-\d{1,2}\.\d{1,3}", self.source).group(0)
>          else:
>              tarfiles = glob.glob(os.path.join(self.srcdir, f"{DEFAULT_KERNEL_PREFIX}*"))
>              if tarfiles:
> -- 
> 2.39.3
> 
> 

Almost there.

Firstly I would remove the asterisk. Whoever created the intial regular 
expression was probably mixing up the shell pattern matching where that 
would match 0 or more of any character, but as a regular expression it 
means to match 0 or more of the previous character which is a dot. The 
intention was probably to allow characters like "rc" (release candidate).
There is no point in matching multiple dots, so just remove it.

There is no need to use that kind of string concatenation, just group
the entire first pattern with parenthesis and the second one too with the 
'|' inbetween, like this

r"(\d{1,2}\.\d{1,3}\.\d{1,3})|(\d{1,2}\.\d{1,3})"

Finally note that in the x.y.z pattern the 'z' is the
one most likely to reach 3-digits, I changed it above.

Make sure to test in both your interactive interpreter and finally
in rteval itself.

Thanks!

John

