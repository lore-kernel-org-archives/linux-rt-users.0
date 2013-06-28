From: Lars Segerlund <lars.segerlund@gmail.com>
Subject: paging in realtime context ...
Date: Fri, 28 Jun 2013 16:14:43 +0200
Message-ID: <CAF-VNaov5Y76uhm6W3zPD-oe8xik4ER69Pw8V+dPP8JdJ4gb-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:43769 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754850Ab3F1OOo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 28 Jun 2013 10:14:44 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so1062145pdj.0
        for <linux-rt-users@vger.kernel.org>; Fri, 28 Jun 2013 07:14:43 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

 Quick question, if I mlock my app and prefault the stacks, what
happens if I haven't linked static and use a library ?

 Surely a bunch of pagefaults ?

 If not my thinking is broken, which might a possibility ... I just
wanted to make sure since I really don't trust logical conclusions in
this case.

 / regards, Lars Segerlund.
