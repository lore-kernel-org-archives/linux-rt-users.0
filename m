Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F31C433EF
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 Jun 2022 07:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbiF2HC2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 29 Jun 2022 03:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbiF2HBz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 29 Jun 2022 03:01:55 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD20313A3
        for <linux-rt-users@vger.kernel.org>; Tue, 28 Jun 2022 23:58:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5637B5D989;
        Wed, 29 Jun 2022 08:58:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1656485931; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         in-reply-to:references; bh=BNyy0HgjleQZbLLxpbdEQEcX5ad3ovR5gJjkEdpYsGc=;
        b=EDcpxAZhP3Dbx+7Tw/GiQl1DUA0WnEl1G95ericIbKYUGgItJjzSKtWKuPwcKqPOov+5Ox
        x2M+Dq8ICIdqJxcGsNXsk+R5jn+im45Vldg5DeDXOvNpMpvk3RMiVod2D9ZK4G7C9SQmlH
        hagC0QIH4ZxKR5+7Z5jALu+e5Ls+welGeYMZ9Y6+nWlN5TnKf4knYZrt/Sl3Rlkb9mB+Lb
        UnXwmbovlzntDfLfV2oDA4BHp3E6kd9sSRyqGnzapfD2e/v1l4IA32TivMShLl2xgLAdIU
        GKXdHl0DOCZ2GpIfug1SRlQeMnhgvZF0D1ONLhOtr+A0DMiVEdQd1MQnZ9Ouqw==
Date:   Wed, 29 Jun 2022 08:58:48 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     Song Chen <chensong_2000@189.cn>
Cc:     linux-rt-users@vger.kernel.org, jkacur@redhat.com,
        williams@redhat.com
Subject: Re: [PATCH v2] sched_deadline/cyclicdeadline add tracelimit
Message-ID: <20220629065848.zpppngaem7qqazzf@beryllium.lan>
References: <1655448052-12537-1-git-send-email-chensong_2000@189.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655448052-12537-1-git-send-email-chensong_2000@189.cn>
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

On Fri, Jun 17, 2022 at 02:40:52PM +0800, Song Chen wrote:
>  static void usage(int error)
> @@ -689,6 +697,7 @@ static void usage(int error)
>  	       "                           (default 500us).\n"
>  	       "-t NUM   --threads         The number of threads to run as deadline (default 1).\n"
>  	       "-q       --quiet           print a summary only on exit\n"
> +	       "-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"

Please also consider to update the man pages.

Daniel
