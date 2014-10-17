From: Pavel Vasilyev <pavel@pavlinux.ru>
Subject: Re: Hang writing to nfs-mounted filesystem from client, all nfsd
 tasks on server blocked in D
Date: Fri, 17 Oct 2014 22:01:53 +0400
Message-ID: <54415991.1070907@pavlinux.ru>
References: <544156FE.7070905@windriver.com>
Reply-To: pavel@pavlinux.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Chris Friesen <chris.friesen@windriver.com>,
	linux-nfs@vger.kernel.org,
	"J. Bruce Fields" <bfields@fieldses.org>,
	linux-ext4@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from imp01.mtu.ru ([62.5.255.10]:37818 "EHLO imp01.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753167AbaJQSCF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 17 Oct 2014 14:02:05 -0400
In-Reply-To: <544156FE.7070905@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Ext4 it's a kiddy fs, use XFS, Luke!
