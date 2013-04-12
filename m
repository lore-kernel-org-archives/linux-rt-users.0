From: Romain Geissler <romain.geissler@gmail.com>
Subject: Multiple readers on multiple posix queues
Date: Fri, 12 Apr 2013 10:53:13 +0200
Message-ID: <CAF+LTeeELsNYj+wQZ_NC=5+2G2AqvLgpuwBxsOwM+S72WzckKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:59705 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753151Ab3DLIxO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 12 Apr 2013 04:53:14 -0400
Received: by mail-oa0-f49.google.com with SMTP id j6so2282453oag.8
        for <linux-rt-users@vger.kernel.org>; Fri, 12 Apr 2013 01:53:13 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

We are currently facing an issue when reading in a set of several
posix queues (let's say 2 different mqueues) from several processes.
We are currently using epoll_wait to wait for an incoming message on
either queue, then mq_timedreceive to retrieve it from the queue.

This is an issue when the number of reader process grows, as if we
send only one message on a queue, all processes are awaken when
epoll_wait returns, and all processes try to fetch the message. We
would like to fix this and remove those useless kernel space/user
space switchs.

Is there any way to run a mq_receive/mq_timedreceive on several
queues, that would awake only one process? Something more or less like
epoll, but that also fetches a message from the readable queues.

Romain
