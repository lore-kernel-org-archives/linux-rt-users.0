Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D74C2D0E4
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Nov 2020 07:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72143246B8
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Nov 2020 07:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgKSHIa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 19 Nov 2020 02:08:30 -0500
Received: from mo-csw-fb1515.securemx.jp ([210.130.202.171]:41310 "EHLO
        mo-csw-fb.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgKSHI3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 19 Nov 2020 02:08:29 -0500
X-Greylist: delayed 804 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Nov 2020 02:08:28 EST
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1515) id 0AJ6t4dk009642; Thu, 19 Nov 2020 15:55:04 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 0AJ6sMAX017443; Thu, 19 Nov 2020 15:54:22 +0900
X-Iguazu-Qid: 34tr8pqEJDGbjlNQmi
X-Iguazu-QSIG: v=2; s=0; t=1605768862; q=34tr8pqEJDGbjlNQmi; m=dQdS/AfgCxNhL9jUyUd5RjGT2SOqwQW9PBezs6c76gc=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
        by relay.securemx.jp (mx-mr1513) id 0AJ6sLBq005730;
        Thu, 19 Nov 2020 15:54:21 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
        by imx12.toshiba.co.jp  with ESMTP id 0AJ6sLA1006243;
        Thu, 19 Nov 2020 15:54:21 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 0AJ6sKn9008618;
        Thu, 19 Nov 2020 15:54:21 +0900
From:   Punit Agrawal <punit1.agrawal@toshiba.co.jp>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        <linux-rt-users@vger.kernel.org>
Subject: Re: [rt-tests v1 01/12] cyclicdeadline: Remove dead code
References: <20201118190642.16006-1-dwagner@suse.de>
        <20201118190642.16006-2-dwagner@suse.de>
Date:   Thu, 19 Nov 2020 15:54:20 +0900
In-Reply-To: <20201118190642.16006-2-dwagner@suse.de> (Daniel Wagner's message
        of "Wed, 18 Nov 2020 20:06:31 +0100")
X-TSB-HOP: ON
Message-ID: <87wnyh7s6b.fsf@kokedama.swc.toshiba.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Daniel,

One comment / query below -

Daniel Wagner <dwagner@suse.de> writes:

> my_sprintf() is not used, remove it.
>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  compare.py                          | 12 ++++++++++++
>  src/sched_deadline/cyclicdeadline.c | 13 -------------
>  2 files changed, 12 insertions(+), 13 deletions(-)
>  create mode 100644 compare.py
>
> diff --git a/compare.py b/compare.py
> new file mode 100644
> index 000000000000..7fb6ae818a00
> --- /dev/null
> +++ b/compare.py
> @@ -0,0 +1,12 @@
> +with open('old', 'r') as old:
> +    with open('new', 'r') as new:
> +        for ol in old.readlines():
> +            new.seek(0)
> +            for nl in new.readlines():
> +                o = ol.split()
> +                n = nl.split()
> +
> +                if o[8] == n[8]:
> +                    d = int(n[4]) - int(o[4])
> +                    p = d/int(o[4]) * 100
> +                    print('{:20} {:>8} {:>8} {:>6} {:>2.2}%'.format(o[8], o[4], n[4], d, p))

This hunk seems to be unrelated and also not mentioned in the commit
log. Perhaps it's accidentally part of this commit?

Thanks,
Punit

[...]

