Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D884C1B0E3
	for <linux-rt-users@archiver.kernel.org>; Mon, 14 Dec 2020 09:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2889922AAA
	for <linux-rt-users@archiver.kernel.org>; Mon, 14 Dec 2020 09:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730890AbgLNJbn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 14 Dec 2020 04:31:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:46034 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730483AbgLNJbc (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 14 Dec 2020 04:31:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 04B27AC90;
        Mon, 14 Dec 2020 09:30:50 +0000 (UTC)
Date:   Mon, 14 Dec 2020 10:30:49 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     RT <linux-rt-users@vger.kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 1/3] rt-tests: determine_maximum_mpps.sh: Add a menu to
 get user settings.
Message-ID: <20201214093049.pl2guoij4kjw2ifc@beryllium.lan>
References: <20201209183100.16836-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209183100.16836-1-jkacur@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi John,

On Wed, Dec 09, 2020 at 01:30:58PM -0500, John Kacur wrote:
> Incorporate the functionality of the get_cpuinfo_mhz.sh script into
> determine_maximum_mpps.sh so that get_cpuinfo_mhz.sh can be removed.
> 
> Currently determine_maximum_mpps.sh (part of queuelat) asks the user
> to edit the PREAMBLE in the script to set the environment.
> 
> Get rid of this by creating a menu that allows the user the set these
> variables from a menu when running the script.
> 
> Here is the output from running the script with the -h option
> 
> ./src/queuelat/determine_maximum_mpps.sh -h
> Usage:
> determine_maximum_mpps.sh [OPTIONS]
> 
> -c cpulist
> 	List of processors to run on. The default is processor 0
> 	Numbers are separated by commas and may include ranges. Eg. 0,3,7-11

Does the option also do CPU affinity. In this case I would suggest to
use '-a' to go with the pattern.

What about long options? Long options are propably a bit harder to
implement in shell but it would be good in my opinion to keep all those
tests commands as close as possible.

Thanks,
Daniel

