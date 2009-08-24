From: GeunSik Lim <leemgs1@gmail.com>
Subject: About update-server-info of rt-tests git tree
Date: Mon, 24 Aug 2009 09:25:39 +0900
Message-ID: <1251073539.2153.61.camel@centos51>
Reply-To: leemgs1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.225]:40066 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbZHXAZt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 23 Aug 2009 20:25:49 -0400
Received: by rv-out-0506.google.com with SMTP id f6so603831rvb.1
        for <linux-rt-users@vger.kernel.org>; Sun, 23 Aug 2009 17:25:49 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



Dear Clarks , 

I have one favor for you. 
As you know, Some developers often use http protocol(80) without git protocol(9418) 
because of firewall problems. Recently, I used " git clone" command with http protocol. 
But, I can not get rt-tests v0.50.

This is a history. 
fedora11$> git clone http://www.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git
fedora11$> cd rt-tests
fedora11$> git tag
v0.18
v0.19
v0.20
v0.21
v0.22
v0.23
v0.24
v0.25
v0.26
v0.27

Please, Can you run below command for http protocol users? 
e.g) git update-server-info [enter]


Thanks, 
GeunSik Lim, 


-----------------------------------------------
To unsubscribe from this list: send the line "unsubscribe linux-***" 
in the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

GeunSik Lim ( Samsung Electronics )
e-Mail  :1) geunsik.lim@samsung.com
         2) leemgs@gmail.com , leemgs1@gmail.com
HomePage: http://blog.naver.com/invain/
-----------------------------------------------

