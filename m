Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4BAC4361B
	for <linux-rt-users@archiver.kernel.org>; Wed, 16 Dec 2020 06:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 120BB23130
	for <linux-rt-users@archiver.kernel.org>; Wed, 16 Dec 2020 06:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgLPGX2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 16 Dec 2020 01:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725274AbgLPGX2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 16 Dec 2020 01:23:28 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198A7C0613D6
        for <linux-rt-users@vger.kernel.org>; Tue, 15 Dec 2020 22:22:48 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id p5so21553295iln.8
        for <linux-rt-users@vger.kernel.org>; Tue, 15 Dec 2020 22:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=YbmnZjfMJh32QJn3uwybW89HCwrvFr4cRD7phTWxshM=;
        b=HxXHYBGPz8ZufPClYLLZsVaRsal6LZ6daeQvX+OM1Nn42jfc5LHa2HvU3YWejX5wla
         ZE4CSvtfcDAKY+MC01563E/E9qCt4eDtxRn71bhc43S2Rn6O8fy8Rk0yjLTRBqR4IMZ1
         knON7JN67TJHJH8XW2lz2KENyzK6YwyCPUZBnpFerSgAarSDrOdNzNZHXftHcucJg26o
         ciGFBmI8mZMB0x4bTZCNunQxS/11vnSUttLvtP+0ndecREBobSuzvVIIV65xLNKd4taB
         jmYbdcFBswDtqkYqGnak1XPRfTNrLVOiPlAoLfO1/SAjtEJAmuZihsArStuq7IknoHEt
         kBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=YbmnZjfMJh32QJn3uwybW89HCwrvFr4cRD7phTWxshM=;
        b=ebe2xv0R016F+kS3QehRIrvb7Z5yJd5+drilCb9FDi59pkid+178uscxOfSXiCybNh
         p5KYEsn5LxMSUZgwgQH47r0aZhMs6OFAEqPbNtwATV5+En0E/aKBYlci7ybAC/nebYbT
         UR8Iu97jIfF98z/kpm1m1H9PTSEn+3J9RK5qfUKdohtnVPgPWPBE1ZiRX+JuKlapi47i
         Behosts26fYj7ua0qQf/v7KMBxH5h/+KWh9r9u70LOa1FvvUHCGrQwyj++MV71xeGuXC
         WnUl67sfzB9HcaE6cq7BKAm6Xc7wxNhEPFlU7FhgAEShs3c6ASUWkJRG/oDMAFrMAWtV
         A9MQ==
X-Gm-Message-State: AOAM532Fr4/XkBeC07DVzOJq2/PefXWP2QJB+ZLd3Eq4tM8FIe/KROJJ
        u5ZekmlDjKd8N6dNBaXkmeEosZGKcVqayQ==
X-Google-Smtp-Source: ABdhPJx6ZnxcSpAzSy+BtkObb+YLGlmXM4xDUdbuMN+GoL5hq+1L79Qhl0ZWLAhz/3OhdDkkBBTSbQ==
X-Received: by 2002:a92:d3c6:: with SMTP id c6mr43995282ilh.7.1608099767481;
        Tue, 15 Dec 2020 22:22:47 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-11-174-88-121-241.dsl.bell.ca. [174.88.121.241])
        by smtp.gmail.com with ESMTPSA id n4sm530671ilm.63.2020.12.15.22.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 22:22:46 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Wed, 16 Dec 2020 01:22:36 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     RT <linux-rt-users@vger.kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 1/3] rt-tests: determine_maximum_mpps.sh: Add a menu to
 get user settings.
In-Reply-To: <20201214093049.pl2guoij4kjw2ifc@beryllium.lan>
Message-ID: <9b24db5-61d2-9d3c-7f5d-271e6366add2@redhat.com>
References: <20201209183100.16836-1-jkacur@redhat.com> <20201214093049.pl2guoij4kjw2ifc@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Mon, 14 Dec 2020, Daniel Wagner wrote:

> Hi John,
> 
> On Wed, Dec 09, 2020 at 01:30:58PM -0500, John Kacur wrote:
> > Incorporate the functionality of the get_cpuinfo_mhz.sh script into
> > determine_maximum_mpps.sh so that get_cpuinfo_mhz.sh can be removed.
> > 
> > Currently determine_maximum_mpps.sh (part of queuelat) asks the user
> > to edit the PREAMBLE in the script to set the environment.
> > 
> > Get rid of this by creating a menu that allows the user the set these
> > variables from a menu when running the script.
> > 
> > Here is the output from running the script with the -h option
> > 
> > ./src/queuelat/determine_maximum_mpps.sh -h
> > Usage:
> > determine_maximum_mpps.sh [OPTIONS]
> > 
> > -c cpulist
> > 	List of processors to run on. The default is processor 0
> > 	Numbers are separated by commas and may include ranges. Eg. 0,3,7-11
> 
> Does the option also do CPU affinity. In this case I would suggest to
> use '-a' to go with the pattern.
> 
> What about long options? Long options are propably a bit harder to
> implement in shell but it would be good in my opinion to keep all those
> tests commands as close as possible.
> 
> Thanks,
> Daniel
> 
> 

The script is using taskset to set the cpu affinity, and so it uses
-c to match the option in taskset. However the script also uses
taskset to run queuelat which uses -c to mean cycles-per-packet.

I am fine with changing this option to -a to match cyclictest and other 
tests in the suite. I'll send a patch to do that.

Yeah, long options are a PITA in shell script, I think I might just
convert the script to python where command line options are a breeze.

That will come in a later patch.

John
