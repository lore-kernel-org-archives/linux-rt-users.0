Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710B1C433E6
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 16:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B72064E8A
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 16:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbhBJQiY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 10 Feb 2021 11:38:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:59154 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232783AbhBJQgT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 10 Feb 2021 11:36:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D5C7CAB98;
        Wed, 10 Feb 2021 16:35:37 +0000 (UTC)
Date:   Wed, 10 Feb 2021 17:35:37 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Peter Xu <peterx@redhat.com>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v2 11/18] ptsematest: Streamline usage output and man
 page
Message-ID: <20210210163537.t2tt3nyuqgkfzbl3@beryllium.lan>
References: <20201007085653.11961-1-dwagner@suse.de>
 <20201007085653.11961-12-dwagner@suse.de>
 <20210210160847.GI103365@xz-x1>
 <20210210162559.GJ103365@xz-x1>
 <20210210163057.ts3zy274abnsnlvn@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210163057.ts3zy274abnsnlvn@beryllium.lan>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -655,16 +655,10 @@ static void parse_options(int argc, char *argv[])
                         */
                        g.single_preheat_thread = true;
                        break;
-               case 'v':
-                       /*
-                        * Because we always dump the version even before parsing options,
-                        * what we need to do is to quit..
-                        */
-                       exit(0);
-                       break;
                case 'z':
                        g.output_omit_zero_buckets = 1;
                        break;
+               case 'v':
                case 'h':
                        usage(0);
                        break;



$ ./oslat -v
oslat V 1.10
Usage:
oslat <options>

This is an OS latency detector by running busy loops on specified cores.
Please run this tool using root.

Available options:

-b, --bucket-size      Specify the number of the buckets (4-1024)
-B, --bias             Add a bias to all the buckets using the estimated mininum
-c, --cpu-list         Specify CPUs to run on, e.g. '1,3,5,7-15'
-C, --cpu-main-thread  Specify which CPU the main thread runs on.  Default is cpu0.
-D, --duration         Specify test duration, e.g., 60, 20m, 2H
                       (m/M: minutes, h/H: hours, d/D: days)
-f, --rtprio           Using SCHED_FIFO priority (1-99)
-m, --workload-mem     Size of the memory to use for the workload (e.g., 4K, 1M).
                       Total memory usage will be this value multiplies 2*N,
                       because there will be src/dst buffers for each thread, and
                       N is the number of processors for testing.
-s, --single-preheat   Use a single thread when measuring latency at preheat stage
                       NOTE: please make sure the CPU frequency on all testing cores
                       are locked before using this parmater.  If you don't know how
                       to lock the freq then please don't use this parameter.
-T, --trace-threshold  Stop the test when threshold triggered (in us),
                       print a marker in ftrace and stop ftrace too.
-v, --version          Display the version of the software.
-w, --workload         Specify a kind of workload, default is no workload
                       (options: no, memmove)
-z, --zero-omit        Don't display buckets in the output histogram if all zeros.



The other tests print also the usage text which included the version if
you provided '--version'. So this would make it behave in the same way.
Good enough?
