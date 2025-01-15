Received: from nexthop.alexanderwerner.net (nexthop.alexanderwerner.net [158.69.48.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7A314884F
	for <linux-rt-users@vger.kernel.org>; Wed, 15 Jan 2025 15:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.48.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736954700; cv=none; b=I8T7HwBxLsvhjFFX39Bd73XdDkIIUZDeLsD2kjksej7cviUrmDQOg8ytQmi89eqbC67hgcDiF/zFqE1kSpnIVLbgBHFMN09oNZeyZNm6cn5aaSUUz8qNvigReQIWIbVnbGMR+wpTU1AoF1B368Ni4UMPnTCsnjs/GIS/AkuP0Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736954700; c=relaxed/simple;
	bh=dTzGU8/AqDPfTPYUOh+o4bMjpprpCQtqakNOVS3m2nU=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=gb1fXf0bxhismIlS/oLHc4e0xGx+YhBkiSp3UygJ0lKEimpupplehXPiIWuKKdT7V9QPBhFMq2TrJd7QTyM0DqvVk49RB29EFhF/7C47xSu/BNpbDDxT5sbFgt4AzpzJf+w87yQfvjCHZesqdGIi530AoQRaognyFSpnjH4HSr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alexanderwerner.net; spf=pass smtp.mailfrom=alexanderwerner.net; dkim=pass (1024-bit key) header.d=alexanderwerner.net header.i=@alexanderwerner.net header.b=HSCYY0jg; arc=none smtp.client-ip=158.69.48.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alexanderwerner.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alexanderwerner.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alexanderwerner.net header.i=@alexanderwerner.net header.b="HSCYY0jg"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alexanderwerner.net;
	s=mail; t=1736954697;
	bh=dTzGU8/AqDPfTPYUOh+o4bMjpprpCQtqakNOVS3m2nU=;
	h=Subject:From:To:Date:From;
	b=HSCYY0jg5QBjtcFwRib9kLRKimPYmwBMq8h5LWp35P7C1D5rTKz+mscg4PGpQJwBp
	 3Co7yWfx0WDWajJuRHHvyvq4o4zFhphSqbdSjZ8qjmI5okwRIdZpMWJ3Xnk84H25vh
	 ENWZkvWx5wPUtbuPUi1MMmQrF25y0/1pQy//Q5qw=
Received: from [IPv6:2001:4958:3220:3301:dbf8:2cd3:b5b2:89bb] (unknown [IPv6:2001:4958:3220:3301:dbf8:2cd3:b5b2:89bb])
	by nexthop.alexanderwerner.net (Postfix) with ESMTPSA id 939EB65FCA
	for <linux-rt-users@vger.kernel.org>; Wed, 15 Jan 2025 15:24:57 +0000 (UTC)
Message-ID: <70b66c69bdd3d4cf8dd7a7f17051b074b9fbcf48.camel@alexanderwerner.net>
Subject: /sys/kernel/realtime in mainline
From: Alexander Werner <linux-rt@alexanderwerner.net>
To: linux-rt-users@vger.kernel.org
Date: Wed, 15 Jan 2025 10:24:41 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello,

this is about testing if a kernel has been compiled with PREEMPT_RT.
Previously, the PREEMPT_RT patch created a file /sys/kernel/realtime to
enable user space tools to detect this. However, this patch has not
been merged (yet?). The commit which creates this file is
	3e7545de923c4e8184c2be0b95341fdc7ef1c193 as pointed out in thread [1]
on the LinuxCNC forum. Many applications in the robotics space also use
the existence of this file to check for PREEMPT_RT such as [2],[3].

My question is if this will be merged later on or the user space will
have to accomodate this change.


Cheers,

Alex



[1]
https://forum.linuxcnc.org/38-general-linuxcnc-questions/54542-real-time-ke=
rel-not-detected-on-patched-6-12?start=3D10
[2]https://github.com/ros-controls/realtime_tools/blob/5b85370c75371a5748b7=
90101802910e53bb12f0/src/realtime_helpers.cpp#L48
[3]
https://github.com/frankaemika/libfranka/blob/fd2951bc76e61d32d835241c40c26=
562148cd457/src/control_tools.cpp#L29
