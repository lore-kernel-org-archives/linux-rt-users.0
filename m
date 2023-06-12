Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D368C7EE2F
	for <linux-rt-users@archiver.kernel.org>; Mon, 12 Jun 2023 18:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbjFLS7L (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 12 Jun 2023 14:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjFLS7K (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 12 Jun 2023 14:59:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B141713
        for <linux-rt-users@vger.kernel.org>; Mon, 12 Jun 2023 11:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686596298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OmQdtDJWOYK1fUh+Arz/ee6rSgi1GIfF3VoP+UxUhkQ=;
        b=QyXxNXNX/IpDSmQzxdbF1OCMoY6EJII6N99odvJhz2Mi8oi0hoNmyFrRunpbYlNX3a56mm
        YxKPjBMopNHx4dzpnXdlKRjJfd7IQYPr9ZbShjkiTyfL9tybwOz3mM7PCRy4UdrLjxCsOq
        2g2Sp1IAk/2dU7z3mgL9G6MqfV6w0AE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-eDki7Id0NMO49b5OM1Ya7w-1; Mon, 12 Jun 2023 14:58:11 -0400
X-MC-Unique: eDki7Id0NMO49b5OM1Ya7w-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-3f9d38c4c30so2953711cf.2
        for <linux-rt-users@vger.kernel.org>; Mon, 12 Jun 2023 11:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686596290; x=1689188290;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OmQdtDJWOYK1fUh+Arz/ee6rSgi1GIfF3VoP+UxUhkQ=;
        b=AIbTDyXou1xtnP/yRr8tRrj50jJc4nw2AbDUie2D1VOW0niZEbbNr4mN4M7Mqw3+Ba
         h7AFcYHccutj+T9++lAgW78xUu7CvIIp5Wx/fn2ffbcfbqItXlieyHESwaaQ1Jju3oki
         9AnKtQZzR53QTWuOuND3faFFcD7Qkfj+nXqybKI+YLIfj5vY32mDwby5Ysfs6Jklc0Pj
         l5jGrwGKy1LocW3HtKBCph6DSo9lD2kxg0i0qcNXubMfVWAbin0rvOVgr9VZwpgmMDJ2
         c+J77beH2JR/9dboOJmUCUW3ugjT6SlQe/EyOX1SbflZvP97A40mRO0fOqgfuTigT/Fi
         W+Mg==
X-Gm-Message-State: AC+VfDyLXHbQfZcpsD6UyoAlqojZoiS4UfW9bjXVjBBiEOxxwXZYIoeV
        N2x6KKF9xweGjOaaI3ViBiLNz81LXJp7vZREOydzLxnUDZTF0Ynp8wYM6yswVaJuaz+uLvzFfDI
        n2kRT65y+krNHmBfOMypgsOEOOOU=
X-Received: by 2002:a05:622a:1492:b0:3f9:d590:8288 with SMTP id t18-20020a05622a149200b003f9d5908288mr11997971qtx.18.1686596290732;
        Mon, 12 Jun 2023 11:58:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6cV1Hiowq2G2m6H0ixhsEkOGSEHfc6Im+5GAxnRYmDjrKOvZTsT8R1lES1/5ljPowrK7dz4g==
X-Received: by 2002:a05:622a:1492:b0:3f9:d590:8288 with SMTP id t18-20020a05622a149200b003f9d5908288mr11997957qtx.18.1686596290476;
        Mon, 12 Jun 2023 11:58:10 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-07-184-147-141-56.dsl.bell.ca. [184.147.141.56])
        by smtp.gmail.com with ESMTPSA id h27-20020ac8777b000000b003f6f83de87esm3595034qtu.92.2023.06.12.11.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 11:58:10 -0700 (PDT)
Date:   Mon, 12 Jun 2023 14:58:09 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Anubhav Shelat <ashelat@redhat.com>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2 07/10] rteval: Use f-strings in services.py
In-Reply-To: <20230601202734.813515-8-ashelat@redhat.com>
Message-ID: <9d553fba-ab83-ed83-fdf0-f2ee53c52c9@redhat.com>
References: <20230601202734.813515-1-ashelat@redhat.com> <20230601202734.813515-8-ashelat@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 1 Jun 2023, Anubhav Shelat wrote:

> Use f-strings in services.py
> 
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> ---
>  rteval/sysinfo/services.py | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/rteval/sysinfo/services.py b/rteval/sysinfo/services.py
> index c85980e19165..a87b4abeea76 100644
> --- a/rteval/sysinfo/services.py
> +++ b/rteval/sysinfo/services.py
> @@ -55,17 +55,17 @@ class SystemServices:
>                  break
>          if not servicesdir:
>              raise RuntimeError("No services dir (init.d) found on your system")
> -        self.__log(Log.DEBUG, "Services located in %s, going through each service file to check status" % servicesdir)
> +        self.__log(Log.DEBUG, f"Services located in {servicesdir}, going through each service file to check status")
>          ret_services = {}
>          for service in glob.glob(os.path.join(servicesdir, '*')):
>              servicename = os.path.basename(service)
>              if not [1 for p in reject if fnmatch.fnmatch(servicename, p)] \
>                      and os.access(service, os.X_OK):
> -                cmd = '%s -qs "\(^\|\W\)status)" %s' % (getcmdpath('grep'), service)
> +                cmd = f'{getcmdpath("grep")} -qs "\(^\|\W\)status)" {service}'
>                  c = subprocess.Popen(cmd, shell=True, encoding='utf-8')
>                  c.wait()
>                  if c.returncode == 0:
> -                    cmd = ['env', '-i', 'LANG="%s"' % os.environ['LANG'], 'PATH="%s"' % os.environ['PATH'], 'TERM="%s"' % os.environ['TERM'], service, 'status']
> +                    cmd = ['env', '-i', f'LANG="{os.environ["LANG"]}"', f'PATH="{os.environ["PATH"]}"', f'TERM="{os.environ["TERM"]}"', service, 'status']
>                      c = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, encoding='utf-8')
>                      c.wait()
>                      if c.returncode == 0 and (c.stdout.read() or c.stderr.read()):
> @@ -79,8 +79,8 @@ class SystemServices:
>  
>      def __get_services_systemd(self):
>          ret_services = {}
> -        cmd = '%s list-unit-files -t service --no-legend' % getcmdpath('systemctl')
> -        self.__log(Log.DEBUG, "cmd: %s" % cmd)
> +        cmd = f'{getcmdpath("systemctl")} list-unit-files -t service --no-legend'
> +        self.__log(Log.DEBUG, f"cmd: {cmd}")
>          c = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, encoding='utf-8')
>          for p in c.stdout:
>              # p are lines like b'servicename.service status'
> @@ -133,7 +133,7 @@ def unit_test(rootdir):
>  
>          return 0
>      except Exception as err:
> -        print("** EXCEPTION: %s" % str(err))
> +        print(f"** EXCEPTION: {str(err)}")
>          return 1
>  
>  
> -- 
> 2.31.1
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

