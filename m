Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163C6110B
	for <linux-rt-users@vger.kernel.org>; Thu, 28 Sep 2023 08:39:16 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F512AC
	for <linux-rt-users@vger.kernel.org>; Thu, 28 Sep 2023 01:39:14 -0700 (PDT)
Date: Thu, 28 Sep 2023 10:39:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1695890353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MxXQNcl/6M7HRioWtab8fwSl4RCbWfHbJHmfidaT08w=;
	b=s08PlVMCioVS3gV8w5wzo+3KNgl891XcpvoI09PPSNFnsLvesZXJsOUcxO5ZKxObKfJnHz
	9wV86dFEERDRw94FUwReFkmE3z4qwXJVwF7NAKGrNUxVeWA54MmumMN6DQjJ+VeXUo6/NJ
	2DwF8lIBvvHJDjpaVpaMyxIKyH21DmwE1dpMs7hOjUsqi9fNnQ0cbqHQDpi+ipWqx2x/zy
	QLYXqBjWjxzKjytIhsARyYC4JPQH0tlZpXXY+1484zFgmJLyuWQz/dljx+VhIsDuMnrCD9
	OIK1hrYNlbE3d3R64JIVqlpdIGvUgkcMAiWLHcwNBSRX4HkCpAvr6EMfWD+a4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1695890353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MxXQNcl/6M7HRioWtab8fwSl4RCbWfHbJHmfidaT08w=;
	b=C/llW4It8UySbit3XCCrZtImimInIbmkPFjEZZaO5AsG6tfn1hS8/64/yctlv/5X7Y5uOZ
	CJKhlEMviF+kEpAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Joseph Salisbury <joseph.salisbury@canonical.com>
Cc: linux-rt-users@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: Question Regarding isolcpus
Message-ID: <20230928083909.KySJvo1d@linutronix.de>
References: <5afe86b4-bae3-2fa8-ec33-9686d3c18255@canonical.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5afe86b4-bae3-2fa8-ec33-9686d3c18255@canonical.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-09-26 12:45:14 [-0400], Joseph Salisbury wrote:
> Hi All,
Hi,

> I have a question regarding the isolcpus parameter.=C2=A0 I've been seein=
g this
> parameter commonly used. However, in the kernel.org documentation[0],
> isolcpus is listed as depreciated.
>=20
> Is it the case that isolcpus should not be used at all?=C2=A0 I've seen i=
t used
> in conjunction with taskset.=C2=A0 However, should we now be telling rt u=
sers to
> use only cpusets in cgroups?=C2=A0 I see that CPUAffinity can be set in
> /etc/systemd/system.conf.=C2=A0 Is that the preferred method, so the proc=
ess
> scheduler will automatically migrate processes between the cpusets in the
> cgroup cpuset or the list set by CPUAffinity?

Frederic might know if there is an actual timeline to remove it. The
suggestions since then is to use cpusets which should be more flexible.
There was also some work (which went into v6.1 I think) to be able to
reconfigure the partitions at run-time while isolcpus=3D is a boot time
option.
=46rom what I remember, you have a default/system cpuset which all tasks
use by default and then you can add another cpuset for the "isolated"
CPUs. Based on the partition it can be either the default one or
isolated [0]. The latter would exclude the CPUs from load balancing
which is what isolcpus=3D does.

[0] f28e22441f353 ("cgroup/cpuset: Add a new isolated cpus.partition type")

> Thanks,
>=20
> Joe

Sebastian
