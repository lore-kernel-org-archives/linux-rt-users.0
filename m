Return-Path: <SRS0=koMT=DI=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DA8C4727E
	for <linux-rt-users@archiver.kernel.org>; Thu,  1 Oct 2020 20:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EA1E207FB
	for <linux-rt-users@archiver.kernel.org>; Thu,  1 Oct 2020 20:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KEio7Tn1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbgJAUFN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 1 Oct 2020 16:05:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60829 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726606AbgJAUFM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 1 Oct 2020 16:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601582711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=69752MlpGhETXXcfjzDcYflLtqisEJ18KkBk/F/GFkc=;
        b=KEio7Tn1IwS+IWq8DyMhlBMgzKY5VEcMeA+9X1Lhy7cGyhsfU8ydDtKoOkg8sPVDKyzOEL
        58cIpa3ghWcY+UuDiGEHCDu3auTV52xmHo1YBBYAg7C6yG6Od4BDPUVSMEWa8maRtWGgz6
        jirrt70wV7bL7r9hhSzgPWx7bQDoS90=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-cd-UBGrSNlKNeF5SAxnA7g-1; Thu, 01 Oct 2020 16:05:09 -0400
X-MC-Unique: cd-UBGrSNlKNeF5SAxnA7g-1
Received: by mail-qv1-f69.google.com with SMTP id 99so3846841qva.1
        for <linux-rt-users@vger.kernel.org>; Thu, 01 Oct 2020 13:05:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=69752MlpGhETXXcfjzDcYflLtqisEJ18KkBk/F/GFkc=;
        b=Md+TXbUuK9p6TVY75OF6iQQUZ8kScfYsZlxikg7DbNcosUYEiX/iU936tnnyEoToJO
         7UjlYV5KgXp27rvWhb1p7+oUG/FVwfq1AH30MIwS8k1vJhjKFwNWrh9Ny+9J6Dk26PTx
         3ieMvheq0KNltsSQkXk/1EITTzAmH+krfotHGs4XKVQ359jiBqWxQ8gFCTEPbvj7xeNx
         L7K0/Z872uTG4Xaj2DU+rI/swzKavdzP7sNBjButiE2cx4NBjDfmlJsbxN1KKH7ArvxR
         wOJtVAyVPmBpqmyucV1UJGZpKiC9+4s/pkmG0Niak6/ZJYw+La9bB0qkKcAmcEy3cBZL
         2HrQ==
X-Gm-Message-State: AOAM530iD3b39EKztuC8Kfpn3II40OLzHaAlVI4mCNentIj6Qi1BgBcC
        IXbl/LOa/PlRL7C/C2Gmx5uo0ycRhjkAuXZI/Zy1eDgQ2dwglw1rF7TqUsHzdOsod9qefJgbPOB
        KyRkA0NV4fJzDqvjqHOgQ84VkAV0=
X-Received: by 2002:a37:a88a:: with SMTP id r132mr9067817qke.270.1601582708370;
        Thu, 01 Oct 2020 13:05:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyo/8tFfnMT+cP/8hwYEnaYaZ9SAUogSlX0rdLT91Q6Jk7VW9yJ5aEdbaKiIaiStgwfj5kE4w==
X-Received: by 2002:a37:a88a:: with SMTP id r132mr9067779qke.270.1601582707921;
        Thu, 01 Oct 2020 13:05:07 -0700 (PDT)
Received: from xz-x1 (toroon474qw-lp130-09-184-147-14-204.dsl.bell.ca. [184.147.14.204])
        by smtp.gmail.com with ESMTPSA id e23sm7062572qkl.67.2020.10.01.13.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 13:05:07 -0700 (PDT)
Date:   Thu, 1 Oct 2020 16:05:05 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Randy Witt <randy.e.witt@linux.intel.com>
Cc:     linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>
Subject: Re: rt-tests v1.9 fails to compile on architectures that aren't
 x86_64, i386 or PPC64
Message-ID: <20201001200505.GB3538@xz-x1>
References: <62cb6195-7116-db1d-2af2-264dbd854ddb@linux.intel.com>
 <20200930154522.GD107801@xz-x1>
 <a7cfa682-af20-6b7c-ccd8-cb9ef6303fa8@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a7cfa682-af20-6b7c-ccd8-cb9ef6303fa8@linux.intel.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Oct 01, 2020 at 12:00:20PM -0700, Randy Witt wrote:
> > Another solution (as mentioned by John offlist) is we implement a common frc()
> > like fetching the time.  However since the __measure_cpu_hz() will always try
> > to calculate the cpu HZ, then the HZ could be confusing then.  Considering the
> > "read the processor clock" operation should still be the ideal implementation
> > for frc() (and I really doubt whether there'll be real need to run oslat on
> > other archs...), maybe we can use the simple way for now.
> 
> Would you be willing to help me understand why it wouldn't be useful for
> other archs?

Sorry if I confused you... I never meant that. :)

I tried to dump that error message just to make sure when some other arch
wanted to run this program, then people will know what they need to do is
simply to implement the frc() function on that arch for oslat.c.  I just feel
like providing a common implementation for frc() could be slightly confusing
(as mentioned above, e.g. on hz information).  So maybe it's better to wait for
someone to implement that (I believe shouldn't be hard for a genuine RT user
anyways...).

Thanks,

-- 
Peter Xu

