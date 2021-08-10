Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F673C4338F
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Aug 2021 11:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4300460EC0
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Aug 2021 11:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236941AbhHJLXN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 Aug 2021 07:23:13 -0400
Received: from mga14.intel.com ([192.55.52.115]:25838 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236418AbhHJLXL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Aug 2021 07:23:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10070"; a="214611365"
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="gz'50?scan'50,208,50";a="214611365"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 04:22:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="gz'50?scan'50,208,50";a="484000181"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 10 Aug 2021 04:22:45 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mDPqH-000KUz-96; Tue, 10 Aug 2021 11:22:45 +0000
Date:   Tue, 10 Aug 2021 19:22:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>
Cc:     kbuild-all@lists.01.org, Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <wagi@monom.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] io-wq: remove GFP_ATOMIC allocation off schedule out path
Message-ID: <202108101932.NjfbZMLu-lkp@intel.com>
References: <20210810074054.mll3snv7vqfhef6i@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <20210810074054.mll3snv7vqfhef6i@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Sebastian,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.14-rc5]
[cannot apply to next-20210810]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Sebastian-Andrzej-Siewior/io-wq-remove-GFP_ATOMIC-allocation-off-schedule-out-path/20210810-154135
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 9a73fa375d58fee5262dd16473c8e7522bdf44de
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/7fd11421b3672d0230a9b529445014d99185b387
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Sebastian-Andrzej-Siewior/io-wq-remove-GFP_ATOMIC-allocation-off-schedule-out-path/20210810-154135
        git checkout 7fd11421b3672d0230a9b529445014d99185b387
        # save the attached .config to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/io-wq.c: In function 'create_worker_cb':
>> fs/io-wq.c:286:15: error: 'struct io_worker' has no member named 'wq'; did you mean 'wqe'?
     286 |  wq = worker->wq;
         |               ^~
         |               wqe


vim +286 fs/io-wq.c

   276	
   277	static void create_worker_cb(struct callback_head *cb)
   278	{
   279		struct io_worker *worker;
   280		struct io_wq *wq;
   281		struct io_wqe *wqe;
   282		struct io_wqe_acct *acct;
   283	
   284		worker = container_of(cb, struct io_worker, create_work);
   285		wqe = worker->wqe;
 > 286		wq = worker->wq;
   287		acct = &wqe->acct[worker->create_index];
   288		raw_spin_lock_irq(&wqe->lock);
   289		if (acct->nr_workers < acct->max_workers)
   290			acct->nr_workers++;
   291		raw_spin_unlock_irq(&wqe->lock);
   292		create_io_worker(wq, wqe, worker->create_index);
   293		clear_bit_unlock(0, &worker->create_state);
   294		io_worker_release(worker);
   295	}
   296	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--gKMricLos+KVdGMg
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
HAZAZAeGNwWVMDEgOVejdxQDRpUq14kkSkMmJoGJjrIW3GfOepaQgqIdNeVMG6rlgjMKrzsD
VYWrKagVGlpdS2UQgKUUTrIWRZe6ELBXAE21XIyks6HMCuYuWJHCuIQo3PlAGfoftpw2+2m1
YSuBtpTyfYp00trMHxvibJ9h9Bvwr0QUSS4RPbUoZ4bfOjSxP959O5zrO1Smr+/rZ1hMwGRz
MMEV0/FEhjVsg6u7LLa2aheADoBn9Lw4hlwmLBiMTfOwDXLOqHYzBEeUd4FUAVQyI9djWmXG
OKjxltKYVp9/m5i8C1S5g0BJmsSg0GQ4CjsPSzAoiK2t04K4e+SrNfD1+goXClWuTyJtZNoG
zByXAQmiiAWAWJaANQb40Ecdlzxfv/6yP9X3we8N2gbL+fXw0MTQBiR5gW00VbwhKJJyKbNR
4PBfyk7XFIJKdLhcG2sdEp2ik/hmsm6jWI4tQo+WY0SJhcRStTxlhnRv5YZM47ZBFH10bEcr
3oflp0HPCSfpybdE3H2FYchWtKaVe/ryVtL6Ysq4vf1XbLdgfC8xom+ywWCQRonugzuVTNH6
UpoJKoLLskDfBiDNq19PXw6Pv35/ugdp+lL3NnKBim0Ui21jIgtNazGH7gv8D2EVI5ZKmsvB
l9vc55x1HCZWuTFz18th42loPY2CKS1og4dsm4XxN9HE02QOfrjIuH/QPSMHlPDPXIWSuZdL
gxbOC0YLLDI012IVDEjtCrCR2cxWFPvj+YBnOjAAv0f+E6yGkcaeiXCNQSnyhOow1wOrEz6J
5Ki41zDTHt0YrrWHzUVOPkSMHVOVfoY1aQJ/oWDh+NKPIM6iwg7PardwbUxXvIg+W9zWDSv6
XHWbQUR9u0uk0XD7Jpvl14XMrJICPC9dpN/SFQy2pV+ikXU3cEKEr7JLHNce0I1dbfFXffdy
3n95qO1VdmCjOGdn3Rcyi1KDJm8UtBtjBvxWhWVa9DeUaCLbqwbHPjRtNX7TrBgj1gPExiax
RVeAfIO1M0nr70/Hv4N0/7j/rf5Owp0IjugoQKKLBKx1Yewy2XjEu4lF59Oz4xySJW4SqtGJ
hukY4p2GAxSqyvRu6xDj01RQoVs9dPXQn7fVb969+dSHCDIBggpeoMUqqxGI5ImAs4rghxxv
pPLM4P0wfSswvpToy2+LPKe1zK019DkdUMHby2aFMFy08qlgmIiNEkzv5hrcAyfPCFCVj3V9
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

--gKMricLos+KVdGMg--
