Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4DBC43334
	for <linux-rt-users@archiver.kernel.org>; Sat,  4 Jun 2022 14:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236973AbiFDOsi (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 4 Jun 2022 10:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234515AbiFDOse (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 4 Jun 2022 10:48:34 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B4E101E
        for <linux-rt-users@vger.kernel.org>; Sat,  4 Jun 2022 07:48:32 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id i186so9897879vsc.9
        for <linux-rt-users@vger.kernel.org>; Sat, 04 Jun 2022 07:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=SMaElIA87up0RKhaXdspiQ3cYUQNbZCXuMBa/+MY0YQ=;
        b=oKxSsGqFrEk0GT53yZn7yvhApChFihPfx19iit6smXCqmRdKXZhj4w1LBSJbQDhQrp
         0H3gH0cDe1zUIVQngYvp5N160xJGx4hx1HQtG9u/K6p+l5mXB4cG4GfsuagkzOot+8Iy
         N2ke989mcXa0etPIock71wM4ZlZqxaf2OVX0hTwRBjpwG82Cg/kJEpQlJPUVIHvGOxGu
         zn2il6xDUjA+IFo2onSximkIs1TfB+QXTCNFosIQoLilM4iVVsyPMKznZ8+/FipA40CF
         q/OfuR+Q62TjitlvCdRYZYHFPeMVGqmKea9ywnkFVb+dHgzJGLN81B5t2u2hcVEEsFvo
         Hkmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=SMaElIA87up0RKhaXdspiQ3cYUQNbZCXuMBa/+MY0YQ=;
        b=YgraWXoCgMsZrOy6JIuy+c0ctQ43YkuRRIctDpzfQoALcAU4OzDn1kE9Gicw5FO6df
         PezQl2QHG9xL26i7/S6kd9Xzqj5bd0nSs0IaeNyrcEGbk0bvVYhIcR4mOvrYsFhftHPl
         Cgo1XgNypPqU1LyMRhgnGOrc9Hq9mI7WoxZe0cnUBWorzjSlWvZFRru2NeL0NCzzZo7B
         QRCrBYtrb5We531tgYq/Bd+PgIiZnu0vD92EXQxkLBg/16J0sTEvvLEpvGrcursbisg+
         kan1q9+3kVJ/p8sVmHKZKT7TwwjIzLMRfjcild77rPM9XJaTK5rhuQ5SR7DeHbJvI4YG
         aefw==
X-Gm-Message-State: AOAM530jnnJmfpwFNGH7MPpRtSm3AeKPPTRPhhkafRbjsiufLrmeabXO
        WIOYJAggcEj8QkO60VUML6Uvpua6zbCYmTvc7QTgysCbV1A=
X-Google-Smtp-Source: ABdhPJw1M1T2PD+3pkg3yd+wIdiaBuPW1JkYHz0th1LdjnNQRjF6c/N5mXlWj++oV/bS/o0ENua4OyWKv9GuALReoAY=
X-Received: by 2002:a67:1787:0:b0:337:d8cd:35b2 with SMTP id
 129-20020a671787000000b00337d8cd35b2mr6575513vsx.29.1654354111760; Sat, 04
 Jun 2022 07:48:31 -0700 (PDT)
MIME-Version: 1.0
References: <CA+1+E3Wj9Aw7VP1955XhxNd7YOXO+4VM0tQ_z+z8n08GKirwSg@mail.gmail.com>
In-Reply-To: <CA+1+E3Wj9Aw7VP1955XhxNd7YOXO+4VM0tQ_z+z8n08GKirwSg@mail.gmail.com>
From:   Gautam Thaker <ghthaker@gmail.com>
Date:   Sat, 4 Jun 2022 10:48:21 -0400
Message-ID: <CA+1+E3WHxbcZtHLPueffS1B4K3W3=_dcvg1PYfR5sY3To2YXOQ@mail.gmail.com>
Subject: using a "-M" option on cyclictest defeats the "-D 30" option
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I have noticed that

sudo time ./cyclictest -S -D 30

properly completes the test and exits in 30 seconds. However,

doing:

sudo time ./cyclictest -S -D 30 -M

the test never stops, I have to control-C out of it. Is this intended
behavior? The man page did not say anything about this. I would like
to use both -D <many_hours>   and -M together.

Thanks for any comments.
