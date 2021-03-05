Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84918C433E0
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Mar 2021 07:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F72764DE4
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Mar 2021 07:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbhCEHEn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Mar 2021 02:04:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:56734 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229446AbhCEHEl (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Mar 2021 02:04:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B809EACBF;
        Fri,  5 Mar 2021 07:04:40 +0000 (UTC)
Date:   Fri, 5 Mar 2021 08:04:40 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v1 13/13] ssdd: Add JSON output feature
Message-ID: <20210305070440.lzx2j6wfcg6nuz6a@beryllium.lan>
References: <20210304192220.11272-1-dwagner@suse.de>
 <20210304192220.11272-14-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304192220.11272-14-dwagner@suse.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Mar 04, 2021 at 08:22:20PM +0100, Daniel Wagner wrote:
> +static void write_stats(FILE *f, void *data)
> +{
> +	int *error = data;
> +
> +	fprintf(f, "  \"success\": %d\n", !*error);
> +}

I think I add 'exit_code' to all of the tests.

