Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665EDEB64D9
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Jun 2023 18:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbjF2SuK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 29 Jun 2023 14:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbjF2SuH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 29 Jun 2023 14:50:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF0C2D55
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Jun 2023 11:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688064560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v9egOLfw5+mSB92Nn1ADAysIEJNv93PYsnWi6SczniU=;
        b=WScKZQCSNO68k2bTNxzQshNrjf7E22jVhy61n3Abiu1yhozYqwxKn8y1jYaJbuErO5Y60J
        sxE02XH6OQq+6XtxZYti+vggO43I8NwWz1Wqs1WgIh8DKjD5fMgOXjAE7hsIHPl7DCGyix
        5ZOJt+D6SU9RCUuTC9m1FQjZeyC87/8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-gg1lXOI5NXGg_8vLHImIag-1; Thu, 29 Jun 2023 14:49:19 -0400
X-MC-Unique: gg1lXOI5NXGg_8vLHImIag-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4025c7fba31so11210941cf.1
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Jun 2023 11:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688064558; x=1690656558;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v9egOLfw5+mSB92Nn1ADAysIEJNv93PYsnWi6SczniU=;
        b=WKRZij/P4noKsjj3RSjS2x6LqjwzmcyDvLF3DsBQMTQqi+LW3j8V2Qy8+R7KfH5icU
         U1ONRo5zhfdx75cu4EM46xj9CvSr+SQlXApSXU15d0ycLOpTMTFg5vedF12Rs76PeNOZ
         LvkXqc4EKHZ1/4OO6nNnO3KkkHTSnX3ZGK3789PgQ3WaYTnkLJw4TP1e/CjwD7aRJC0/
         Tu/Jh4MFUHolWeHIFPeQNLmukmODypnKpklrwDbRQ1RG1YcZEx4+Q2t7RqSNABbBRD77
         WAcGCAk9ZygQV90PAWpie2arZnknigytFYjzTXFtio9LFPZ0sAl48UOv02o9yaM55OI0
         Z9XA==
X-Gm-Message-State: ABy/qLYZjm5iBlc9bFsjWIJx3knVZF3N11coDAKTQLLMf/U7xfJ0RXwb
        PAUnUYMwFgqHRPgH3fM6tebqBxM4FarWbtZqZFgZS7xXMd0PCYGzhxjs+bEOttJUno+DvTy5DVS
        dl6w3BztKPfzIPSCz+54HisoACSWNvD8u5c2CNQ==
X-Received: by 2002:ad4:5ce8:0:b0:636:9b4:c808 with SMTP id iv8-20020ad45ce8000000b0063609b4c808mr699157qvb.18.1688064558575;
        Thu, 29 Jun 2023 11:49:18 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEEgrNf9BBX2UHUAAHp4XOqxfbdvNMnOh0PLQZFPsWhNEKmBzAt/ymjwE8pPI8BH+hkTVySdQ==
X-Received: by 2002:ad4:5ce8:0:b0:636:9b4:c808 with SMTP id iv8-20020ad45ce8000000b0063609b4c808mr699141qvb.18.1688064558270;
        Thu, 29 Jun 2023 11:49:18 -0700 (PDT)
Received: from fionn ([184.147.141.56])
        by smtp.gmail.com with ESMTPSA id e14-20020ad4418e000000b006363f2c37f0sm470739qvp.91.2023.06.29.11.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 11:49:17 -0700 (PDT)
Date:   Thu, 29 Jun 2023 14:48:53 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Anubhav Shelat <ashelat@redhat.com>
cc:     linux-rt-users@vger.kernel.org, kcarcia@redhat.com
Subject: Re: [PATCH 1/1] Fixed bug in kcompile where run would fail if
 kcompile-source version had the form x.y instead of x.y.z
In-Reply-To: <20230628215730.738234-1-ashelat@redhat.com>
Message-ID: <95f983ff-c621-3e46-3f59-5afe9c5a195@redhat.com>
References: <20230628215730.738234-1-ashelat@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 28 Jun 2023, Anubhav Shelat wrote:

> Fixed bug in kcompile where run would fail if kcompile-source version
> had the form x.y instead of x.y.z
> 
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> ---
>  rteval/modules/loads/kcompile.py | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
> index 35ee5cbbb52d..445575fb137a 100644
> --- a/rteval/modules/loads/kcompile.py
> +++ b/rteval/modules/loads/kcompile.py
> @@ -175,8 +175,11 @@ class Kcompile(CommandLineLoad):
>          if 'rc' in self._cfg.source:
>              tarfile_prefix = re.search(r"\d{1,2}\.\d{1,3}\-[a-z]*\d{1,2}", self._cfg.source).group(0)
>          else:
> -            tarfile_prefix = re.search(r"\d{1,2}\.\d{1,3}\.*\d{1,2}", self._cfg.source).group(0)
> -
> +            try:
> +                tarfile_prefix = re.search(r"\d{1,2}\.\d{1,3}\.*\d{1,2}", self._cfg.source).group(0)
> +            except AttributeError:
> +                # if the kernel version has the form x.x instead of x.x.x
> +                tarfile_prefix = re.search(r"\d{1,2}\.\d{1,3}", self._cfg.source).group(0)
>          # either a tar.xz or tar.gz might exist. Check for both.
>          xz_file = os.path.join(self.srcdir,"linux-" + tarfile_prefix + ".tar.xz" )
>          gz_file = os.path.join(self.srcdir,"linux-" + tarfile_prefix + ".tar.gz" )
> @@ -193,7 +196,11 @@ class Kcompile(CommandLineLoad):
>          # find our source tarball
>          if self._cfg.source:
>              self.source = self._find_tarball()
> -            kernel_prefix = re.search(r"linux-\d{1,2}\.\d{1,3}\.*\d{1,2}", self.source).group(0)
> +            try:
> +                kernel_prefix = re.search(r"linux-\d{1,2}\.\d{1,3}\.*\d{1,2}", self.source).group(0)
> +            except AttributeError:
> +                # if the kernel version has the form x.x instead of x.x.x
> +                kernel_prefix = re.search(r"linux-\d{1,2}\.\d{1,3}", self.source).group(0)
>          else:
>              tarfiles = glob.glob(os.path.join(self.srcdir, f"{DEFAULT_KERNEL_PREFIX}*"))
>              if tarfiles:
> -- 
> 2.39.3
> 
> 

We don't want to use a try/except block to detect that our regular 
expression didn't match. Instead construct a regular expression that will 
match both the cases of linux-x.y.z.tar.gz and linux-x.y.tar.gz

Note \d{1,2} means one to two digits
you can group those with parenthesis
(\d{1,3}\.){1,2}
The above matches 1 to 3 digits followed by a period and that whole group 
1 to 2 times.

Use your interactive python interpreter to play with the regular 
expression before creating your patch.

John

