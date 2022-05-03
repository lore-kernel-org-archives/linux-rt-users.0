Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0694CC433F5
	for <linux-rt-users@archiver.kernel.org>; Tue,  3 May 2022 14:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237396AbiECOxC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 3 May 2022 10:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237321AbiECOw6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 3 May 2022 10:52:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BDC5393FE
        for <linux-rt-users@vger.kernel.org>; Tue,  3 May 2022 07:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651589362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nn3aqP0/1gEOVtMV30AjwmQjuScFO/x8JSqPLYRfYp4=;
        b=L/1retMoV95CyUNL1ZBzLctorJpX/eLavofwbEsv1g7rmbRNEjbAszDI/+4UyRMMUje7Av
        XLL/SQ8cS8CMk4CBpVrW+HIwrikwIxnGmQyDN79D0a6hDAPhLqjBHe94MMm7Jb6P1lnCEk
        4123DZLidx53PT0Qf2jWl8ttEhb8mCE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-241-wnSSp6J0NaCck8ghqFehDw-1; Tue, 03 May 2022 10:49:03 -0400
X-MC-Unique: wnSSp6J0NaCck8ghqFehDw-1
Received: by mail-qk1-f198.google.com with SMTP id y140-20020a376492000000b0069f7e985c95so12435560qkb.15
        for <linux-rt-users@vger.kernel.org>; Tue, 03 May 2022 07:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=nn3aqP0/1gEOVtMV30AjwmQjuScFO/x8JSqPLYRfYp4=;
        b=na3B1x96zrDprOiqxFPGNtxx7gEZfdKv92YNtv/MPGqhtQw22em6hyUgENsrM7irwH
         I/Pg/uXbRglaHgKayk+Z5TLULyqDojfEE5/7+7DigQM1wXnjmrv5CInRrl69juFt55gS
         WpoNKju9HD/CPB0PVe2MdHMM5jC0grnuoHpfHM6vIzJnZjhjDORN74mem+7et+KmVfTD
         vj+R5fMuH+zsnd8WjM39IAYq621DT4rsZHB/EFkIb0rNupQBp4zJgIgiQ3VmalUdk345
         Hr/3zYtEaMSaZmCuKcd3OSLri10MFnuVQqkDn+rlzM/anS8F/h1V/oCeo+S991hOoHQv
         HETw==
X-Gm-Message-State: AOAM53247ZG6y/FBkOqW4Nhq+bnNGu9CwtzHSz8Gk8bgS6/Zmov3friA
        A+x7zWE0DE/l9/hN328Yv80c4q0SpUjia6qbjoio2bvurZry2Y9A9P1ZT6+p7yvmK1moGH1yWZY
        voah0LE1yG64ePcqsNDlswcNhlEA=
X-Received: by 2002:a05:620a:4709:b0:69f:1725:3a5 with SMTP id bs9-20020a05620a470900b0069f172503a5mr11901922qkb.759.1651586380480;
        Tue, 03 May 2022 06:59:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzA7vv0cN03U2xmUOL2/Fflr4+q0fQ/hwNKVkSJQxqJIDecvXysiU9Kr0qxQdKyqLFnwH4Zag==
X-Received: by 2002:a05:620a:4709:b0:69f:1725:3a5 with SMTP id bs9-20020a05620a470900b0069f172503a5mr11901909qkb.759.1651586380264;
        Tue, 03 May 2022 06:59:40 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-93.dsl.bell.ca. [184.147.143.93])
        by smtp.gmail.com with ESMTPSA id d137-20020a37688f000000b0069fc13ce223sm6212719qkc.84.2022.05.03.06.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 06:59:39 -0700 (PDT)
Date:   Tue, 3 May 2022 09:59:26 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Valentin Schneider <vschneid@redhat.com>
cc:     RT <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] rteval: kcompile: Use systopology to get a list of cpus
 on a node
In-Reply-To: <xhsmhlevivrlz.mognet@vschneid.remote.csb>
Message-ID: <d9ba6cec-253a-9bb7-6097-d04e43741648@redhat.com>
References: <20220429202202.23499-1-jkacur@redhat.com> <xhsmhlevivrlz.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 3 May 2022, Valentin Schneider wrote:

> On 29/04/22 16:22, John Kacur wrote:
> > kcompile gets a lists of cpus on a node but doesn't take into account
> > whether the cpus are online or not.
> >
> > Instead of using the method in kcompile, use the method in systopology,
> > since that will consider whether the cpus are online or not.
> >
> > Reported-by: Valentin Schneider <vschneid@redhat.com>
> > Signed-off-by: John Kacur <jkacur@redhat.com>
> 
> Tested-by: Valentin Schneider <vschneid@redhat.com>
> 
> > ---
> >  rteval/modules/loads/kcompile.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
> > index 367f8dc1ca86..add0cd86cde4 100644
> > --- a/rteval/modules/loads/kcompile.py
> > +++ b/rteval/modules/loads/kcompile.py
> > @@ -202,7 +202,7 @@ class Kcompile(CommandLineLoad):
> >          self.cpus = {}
> >          self.nodes = self.topology.getnodes()
> >          for n in self.nodes:
> > -            self.cpus[n] = [int(c.split('/')[-1][3:]) for c in glob.glob('/sys/devices/system/node/node%s/cpu[0-9]*' % n)]
> > +            self.cpus[n] = self.topology.getcpus(n)
> >              self.cpus[n].sort()
> >
> >              # if a cpulist was specified, only allow cpus in that list on the node
> > --
> > 2.35.1
> 
> 

I added your Tested-by: to the commit.

Thanks for testing!

John

