Return-Path: <SRS0=4gYA=EE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE495C4363A
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 15:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49108207DE
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 15:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I54y7aus"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgJ2PpF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 29 Oct 2020 11:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbgJ2PpF (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 29 Oct 2020 11:45:05 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBDBC0613D2
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Oct 2020 08:45:05 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id s7so3934710iol.12
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Oct 2020 08:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=UCm3fnlymhvjwxcVqrelRBbJ58IRaQFT3ZIt7jHFr54=;
        b=I54y7aus70nx+Bwf2eJMyR3O6wmlvC36xG7aYFSEORLwtg7kCJ6//IQ7VQueub6+Rj
         ppUOnPYfJTpfQ5f0PlAKE+FKoxGU6XpqmKB8bn1maD0IU+Ldx4uXn1IEfSDKv5gni9C2
         YiZoCIYPKVFf3Dmu1sR5jy2PZuQNhkNAWr6Xi8Kc9CSu0LAsfvdeXRqs5mZj6aMIIzs9
         F0+t5OEu01QeosHG48aM1QA/E50Jg/nlCle1gFcU8AwDCDcLf1K0CEfJBkAPoSfb28K4
         Cq0FY1OFzudwoMI22h2jelPNs9F4+yvk4soy9Jw5YD6mcfbK0GOhg1YcXDjVX/fAjzAl
         Ut5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=UCm3fnlymhvjwxcVqrelRBbJ58IRaQFT3ZIt7jHFr54=;
        b=Jj4K1fRl1D0fY7zHM3SwuiDcVa4DnyIRgvZdxz3yz1uCB9Q5s5GnNDT7b8G8HSKOl7
         zq6jrmzm5GVY6+D+FCcRQfQPy37gRO5VEeRd2SBSh58OTsT9I8oO4bC7yUiNZEW9Ac9t
         RJ5PnqHIAP+BSUmR0JEdxT0+S1j37WrRKqh8F7x1Z8SsEfIzPZ7IOYkpNXq6aGz0PX8Z
         BK5caayKZzh8mOK/Ad7x1eSQFk5uwOSrgT76bznI7i1zZ9tsFN6gOdW8S9ZkXEysg+Xu
         yTCo1I1/6NBCg6pVVrvnKGeCWODzbt0C4+6HWLxVGXoF21PRmguVxHcTWl9p7WPmeLzA
         Yi4w==
X-Gm-Message-State: AOAM531GJ7PWBUZmCghW8WnnvQNeBOnN/jrQ7tfiPuhr39hr/qnGNqQO
        w5E15BR5+2fhemYTHFaDxYw=
X-Google-Smtp-Source: ABdhPJwNAV64vLrCGF4XHIDFDwA++aF08vLNw24Usis+7gdPax6rnTz6qhAXfCzNI9Sod1qqbt/8ww==
X-Received: by 2002:a6b:fa0e:: with SMTP id p14mr3902647ioh.208.1603986304659;
        Thu, 29 Oct 2020 08:45:04 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id c9sm2614710ilr.87.2020.10.29.08.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 08:45:04 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Thu, 29 Oct 2020 11:45:00 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <wagi@monom.org>
cc:     Daniel Wagner <dwagner@suse.de>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v2 01/18] rt-util: Move parse_cpumask from
 cyclictest
In-Reply-To: <20201026183425.wxdl3vaoutsrk3bw@beryllium.lan>
Message-ID: <8cc2d53b-41af-77f9-6e91-38d76d4dad0@redhat.com>
References: <20201007085653.11961-1-dwagner@suse.de> <20201007085653.11961-2-dwagner@suse.de> <9afc7214-c957-e86-1ee9-6ed2435b6fa8@redhat.com> <20201026183425.wxdl3vaoutsrk3bw@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Mon, 26 Oct 2020, Daniel Wagner wrote:

> Hi John,
> 
> On Fri, Oct 23, 2020 at 11:46:54AM -0400, John Kacur wrote:
> > >  TARGETS = $(sources:.c=)
> > >  LIBS	= -lrt -lpthread
> > > -RTTESTLIB = -lrttest -L$(OBJDIR)
> > > +RTTESTLIB = -lrttest -L$(OBJDIR) $(NUMA_LIBS)
> > 
> > Currently only cyclictest was compiled with NUMA_LIBS, this change will 
> > compile everything with NUMA_LIBS. I checked the size of the programs, and 
> > they don't grow that much with this change, but they are small programs to
> > begin with, do we want to keep this functionality separate?
> 
> My thinking is, that the most important program for testing seems to be
> cyclictest. Everyone will run cyclictest on the target platform. Thus
> libnuma will be available. So there wont be any new unresolved
> dependencies.
> 
> I traded the size increase for simplification in the code base and build
> setup. Looking at the actual increase (x86_64, stripped) is not too bad:
> 
> 
> program                 old      new     diff
> ---------------------------------------------------
> cyclicdeadline          35488    35552     64 0.18%
> cyclictest              57632    57632      0 0.0%
> deadline_test           43712    43776     64 0.15%
> hackbench               19168    19168      0 0.0%
> oslat                   36040    36072     32 0.089%
> pip_stress              27296    27360     64 0.23%
> pi_stress               44296    48456   4160 9.4%
> pmqtest                 31864    31928     64 0.2%
> ptsematest              31752    31816     64 0.2%
> queuelat                14600    14600      0 0.0%
> rt-migrate-test         31696    31728     32 0.1%
> signaltest              31712    31776     64 0.2%
> sigwaittest             31792    31856     64 0.2%
> ssdd                    14744    14744      0 0.0%
> svsematest              31856    31920     64 0.2%
> 
> 
> pi_stress is a bit odd though. Not sure what's happening there. Will
> look into it.
> 
> So I would prefer to go this route and makes things simpler in the code
> base.
> 
> Thanks,
> Daniel
> 

You're really just simplifying the Makefile, not the code. :)
Well, that and I guess this means I'm asking you to separate any common
numa functionality into a separate lib. If you want you can just pull out
parse_time_string(), and parse_mem_string() for now until we hash out
what we want to do with the numa functionality later.

Does that work for you?

John 
