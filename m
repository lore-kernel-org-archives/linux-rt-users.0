Return-Path: <SRS0=0hJj=WQ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B0EC3A589
	for <linux-rt-users@archiver.kernel.org>; Tue, 20 Aug 2019 06:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB8342082F
	for <linux-rt-users@archiver.kernel.org>; Tue, 20 Aug 2019 06:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4WRMyRe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbfHTGmK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 20 Aug 2019 02:42:10 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38316 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfHTGmK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 20 Aug 2019 02:42:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id m125so1549369wmm.3;
        Mon, 19 Aug 2019 23:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EVxFeA8hyDYWAhFuzK0XsOFXkFtEPR9uwLn/TZ8pG/s=;
        b=e4WRMyRe7HkG7zrmCB9sXvTU2QWJdYkt+Lw4lQS9VZaczTGNQw7VmIHnxlAheqfwOe
         NBSMCdetTgi2FrNlPg7udZJFH1nJPiPXahvRIhSqy9o1NtMqzphPvtgLW11Qm5tWD4+s
         yWontLf44o1EJGjyqi0Uid2qKVY4FoA+Alzo3xj7n3kQ0SLOTRx7+2rSNI5QS5MZSqn8
         o8UJn4tQG/y8h/Joq8QSu65TLz9Z1vqBPa+sYH9FEx4rnM3VtQdD9ewbO5gVTXrFfeu/
         92NsFeKH64fW8NlqsHxEj6jXgmyzK7s9TFhBb2IUpQLDNTsOMVHd3/OL2oPeTyXtpk80
         HIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EVxFeA8hyDYWAhFuzK0XsOFXkFtEPR9uwLn/TZ8pG/s=;
        b=GOfdIJ+ZcVPYyyIIjsA+PmzILAe4QSmcu2ngnBEeZEGYPww5VKuWbxZtD9tbPgJNdO
         kQiq5y2+J1Rbe09NfAE5dI0hsikdrUYovBvPScKEBSEjwgWeJVZVNENwjA9DbgaPQ4TI
         kC/7uReTqkU11NQYJOrw7CzwLag6nTpPFfysJjiwB6mXfAIeaOQ8aEOnntYSALoUNv/N
         41Xiln2glOAGHz2x6l3tjZZeWE4VwYwyJsQiLeRcYBvXKNHVgwj8UUOQONPxmexrpMh/
         QWzA8O4y2WtNiJxVbzowEWwkfe2wheQGXV2FlnmJxSWA0Yn+Ml3O0yQFV3AsNkPKe8gW
         JlOg==
X-Gm-Message-State: APjAAAXRoNwOv32T6mWTbp5p9y3b9IIGSjgaI3Crw6mWDAGvV6PowF1A
        c6dfjakhZfl9XBYYxL+WoCo=
X-Google-Smtp-Source: APXvYqwmJJ/VEbwWYnKm/g5V5nrrZFl+M2P/0Zn8sMgZjJcOfvlxy4LTQM53HoJGjzpbTJ7LGZNZ8A==
X-Received: by 2002:a7b:c091:: with SMTP id r17mr22383277wmh.74.1566283327707;
        Mon, 19 Aug 2019 23:42:07 -0700 (PDT)
Received: from localhost.localdomain ([151.29.237.107])
        by smtp.gmail.com with ESMTPSA id 2sm17673955wrg.83.2019.08.19.23.42.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Aug 2019 23:42:06 -0700 (PDT)
Date:   Tue, 20 Aug 2019 08:42:03 +0200
From:   Juri Lelli <juri.lelli@gmail.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>, kbuild-all@01.org,
        tglx@linutronix.de, bigeasy@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        williams@redhat.com
Subject: Re: [RT PATCH v2] net/xfrm/xfrm_ipcomp: Protect scratch buffer with
 local_lock
Message-ID: <20190820064203.GB6860@localhost.localdomain>
References: <20190819122731.6600-1-juri.lelli@redhat.com>
 <201908201356.Pffozrxv%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201908201356.Pffozrxv%lkp@intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

On 20/08/19 13:35, kbuild test robot wrote:
> Hi Juri,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [cannot apply to v5.3-rc5 next-20190819]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

This seems to be indeed the case, as this patch is for RT v4.19-rt
stable tree:

git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git v4.19-rt

I was under the impression that putting "RT" on the subject line (before
PATCH) would prevent build bot to pick this up, but maybe something
else/different is needed?

Thanks,

Juri
