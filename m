Return-Path: <SRS0=I+/J=CX=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B79CC43461
	for <linux-rt-users@archiver.kernel.org>; Mon, 14 Sep 2020 01:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C2B52177B
	for <linux-rt-users@archiver.kernel.org>; Mon, 14 Sep 2020 01:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rtst-co-kr.20150623.gappssmtp.com header.i=@rtst-co-kr.20150623.gappssmtp.com header.b="XYRxZ9l3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbgINBCA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 13 Sep 2020 21:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgINBB7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 13 Sep 2020 21:01:59 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF7AC06174A
        for <linux-rt-users@vger.kernel.org>; Sun, 13 Sep 2020 18:01:58 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id u48so4951603uau.0
        for <linux-rt-users@vger.kernel.org>; Sun, 13 Sep 2020 18:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rtst-co-kr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=jrJ7ys+eGHxHcOWhnlvUx1/oYRaIFujmytGmh0pGvLs=;
        b=XYRxZ9l3umx9QevOfBfmC1ZnT9O6zsGetk6SeHR1AY3JXOsIzhfS/YPDZ/a+k/Q2Eh
         Ddl5OhS6dmaPBW69QR/dG/2fPhmk/+KbYIr2TumPeajuk6gmp0NdNAECEgeOe2EHXfwK
         BW5Dh/ZXrKi1ddYchRuyCiDYNTa+RfQ4QJnAFC2eNsYQcCklenYe1qkmqHB6bb3ZUEc6
         jJ5YrIuoL457IEw0ooGuGu7m512sQmmI4zJKPMJznOQ/rCTmFecMJcEKAg+SOfpxkUIt
         1xbmzPSJ3+aQ1MrfX7P7aZ5Gu/hToJ5NZ5IFkGDD7kCXnypVxeE5fUngt9ZqY3PMppLm
         huYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=jrJ7ys+eGHxHcOWhnlvUx1/oYRaIFujmytGmh0pGvLs=;
        b=VvANBoq/zYSOvoyTbwrv8pIDnMRQ/tqWgUilMTHD7HQTZveBeqQ51GbrB50XLkdqLK
         bbQ9SpVYoKamJHN1M44JF4gh/xKF+kR7FEljYvMjhoRBPyii6UrAwS85d/BrZFXE0cuh
         +egk9UkWHA5HDLrpyDm3oOUQSqWtKrfPA3cZ4uK8yjS98ACxS0bH1Q1/rXneTGMZf+kO
         Iqezr2KYF0QorJBn7nFWPmfiOj4C+bMgG48W/T8eZgf14DhMfopc650PaQbkmGVCGDcT
         J8qWzCQHOE8u+737jhQ7ukOVlfBY+I4XGESb/Sg2LWnIyeaPBL29/KsM3zuHan6uQYcc
         /nUA==
X-Gm-Message-State: AOAM532Z1hy2PTDq1PqCGyyd2lCj+MqDWj4pPCujTqWKaXPOHAzzbcR5
        xeWUEKARHdZU1wlArT07QKjqP8R2Qz5yGs4lxhBBeuTMM0wtVuWS
X-Google-Smtp-Source: ABdhPJxFP3T3DoNqBthwMaTB+AwhSoPMmlZENeZREOxyIwODwOF82BTjBMyJHkZ+TJ/nD2UOuAVJJn+3zXwpCR1J90k=
X-Received: by 2002:ab0:5f8e:: with SMTP id b14mr5667940uaj.116.1600045317514;
 Sun, 13 Sep 2020 18:01:57 -0700 (PDT)
MIME-Version: 1.0
From:   Jeaho Hwang <jhhwang@rtst.co.kr>
Date:   Mon, 14 Sep 2020 10:01:46 +0900
Message-ID: <CAJk_X9g7+AiD0mq4ZUq02stOg3FvMEzrwXjDfaRJNB7SfD2qgg@mail.gmail.com>
Subject: "RTOS unfriendly" in chipidea udc code
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi RT experts.

We are reviewing device drivers of our product board and found qualmy
codes in chipidea usb device, 4.19.0 applied RT patch(still exists in
current)

The function hw_usb_reset, called by isr_reset_handler, is using
udelay to wait hw reset and commented "RTOS unfriendly". Can I be sure
RT-safe is it? Could you suggest any better alternative?

Thanks. Regards

drivers/usb/chipidea/udc.c:325
/**
 * hw_usb_reset: restart device after a bus reset (execute without
 *               interruption)
 * @ci: the controller
 *
 * This function returns an error code
 */
static int hw_usb_reset(struct ci_hdrc *ci)
{
hw_usb_set_address(ci, 0);

/* ESS flushes only at end?!? */
hw_write(ci, OP_ENDPTFLUSH,    ~0, ~0);

/* clear setup token semaphores */
hw_write(ci, OP_ENDPTSETUPSTAT, 0,  0);

/* clear complete status */
hw_write(ci, OP_ENDPTCOMPLETE,  0,  0);

/* wait until all bits cleared */
while (hw_read(ci, OP_ENDPTPRIME, ~0))
udelay(10);             /* not RTOS friendly */
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

/* reset all endpoints ? */

/* reset internal status and wait for further instructions
  no need to verify the port reset status (ESS does it) */

return 0;
}

--=20
=ED=99=A9=EC=9E=AC=ED=98=B8, Jay Hwang, linux team manager of RTst
010-7242-1593
