Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E540C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Oct 2021 11:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EC15610F9
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Oct 2021 11:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhJNLwx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 14 Oct 2021 07:52:53 -0400
Received: from mail.nearlyone.de ([46.163.114.145]:50572 "EHLO
        mail.nearlyone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbhJNLww (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 14 Oct 2021 07:52:52 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1CD265E415;
        Thu, 14 Oct 2021 13:50:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1634212246; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         in-reply-to:references; bh=b0UPK9XHmg6yJHuj5hLUvcWIZXnWL6c17I088QKs4YY=;
        b=utdJMq3ni4dMPedG7ebLhU3CEDw7tUrw0tQ58CzGJugkou7gAaqDUvHV+9RZ0QiVu5uouH
        X8uFXz1H5JJ9BUTHuByCzkBGTOVHPXtzv9aA4NpkbAuZLevlbKJxlaVmVddP8sqLh0mqXJ
        yKOda1qQeAojR7YyLF0ECcZJoSmGfaHNOH9mjGnY92bN1z7ntS/owWsVr5LAgljKfSt0oz
        zJT+uQpDJaRVg8e/rklMxfR5wI73L8zvIfpTizkaRCnYpNBAtJJ6Vvw3ieBrPKHqcB6nM/
        EyvestCG8vQlIt0vG3nU0tphMfgOz3HwD0942gHznbV+DinJlgpywBfNGDBxbw==
Date:   Thu, 14 Oct 2021 13:50:43 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     Punit Agrawal <punitagrawal@gmail.com>
Cc:     jkacur@redhat.com, Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        williams@redhat.com, linux-rt-users@vger.kernel.org
Subject: Re: [RFC 7/7] rt-tests: cyclictest: Add support to report standard
 deviation
Message-ID: <20211014115043.s3zf5p3s7dglvcjb@carbon.lan>
References: <20211014071247.4165329-1-punitagrawal@gmail.com>
 <20211014071247.4165329-8-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014071247.4165329-8-punitagrawal@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Punit,

On Thu, Oct 14, 2021 at 04:12:47PM +0900, Punit Agrawal wrote:
> @@ -1781,6 +1810,7 @@ static void write_stats(FILE *f, void *data)
>  		fprintf(f, "      \"min\": %ld,\n", s->min);
>  		fprintf(f, "      \"max\": %ld,\n", s->max);
>  		fprintf(f, "      \"avg\": %.2f,\n", s->avg);
> +		fprintf(f, "      \"stddev\": %.2f,\n", calc_stddev(s));
>  		fprintf(f, "      \"cpu\": %d,\n", par[i]->cpu);
>  		fprintf(f, "      \"node\": %d\n", par[i]->node);
>  		fprintf(f, "    }%s\n", i == num_threads - 1 ? "" : ",");

I think in this case you should also increase the version number of the
JSON file. And while at it, I'd love to see the same stats
fixes/extension for the other tools, not just cyclictest.

Daniel
