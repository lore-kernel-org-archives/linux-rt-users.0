Received: from sdfgruop.com (sdfgruop.com [185.239.236.61])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACF616DC15
	for <linux-rt-users@vger.kernel.org>; Wed, 21 Aug 2024 18:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.239.236.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724266645; cv=none; b=L74qAnjERfm/c3fmzOJNQ4LppSyqXv0zBAog32Qd6y0ZkmVFFU+XB4jz1w8ZRVmuCR+pMkByR2F9FwIMuUYy4P1aPMAZoPGfz+6kujVJ7IdMMGekFyh4hb/gVo7p2yqB11A3HKOw/t2Wsje9HhpzMhy2d/m8bf6pzpsUWjiVhVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724266645; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=je1ESzs9mejaZTZjIAL5B1oPQQ4p912JgVcBLyz7HUPAzw0ZeIbImHfaeKGRq2kei8wtey+oNppPnSPLHJ9boUsAGumqVzFVW6fBkij7ZFUTXtKt4zPCxNPqQ5ItrlHsKR/cZRJ+I9kOQ01SKrAFltdlO6egtcA8Rgv6cpZ+Oyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfgruop.com; spf=none smtp.mailfrom=sdfgruop.com; dkim=pass (1024-bit key) header.d=sdfgruop.com header.i=@sdfgruop.com header.b=UVe9rhVc; arc=none smtp.client-ip=185.239.236.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfgruop.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sdfgruop.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sdfgruop.com header.i=@sdfgruop.com header.b="UVe9rhVc"
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed;
	d=sdfgruop.com; s=default; h=From:To:Subject:MIME-Version; bh=2j
	mj7l5rSw0yVb/vlWAYkK/YBwk=; b=UVe9rhVcPfg78f0Qe95qHj5YX+H66EvwD4
	Ib7BhLtXFK8VlopY/4sBNra1NBX66noJYaS8HYX51bHFVsY//4O9X6AJlAhLQ4KQ
	G86H3j8XcOo0UPgUjiHBidC8nfHlzps8EebcZv9Tyg8m4c3QOYvpRlqvnCuct4ia
	6PAtJ5InE=
From: Mail Server <mseyani@sdfgruop.com>
To: linux-rt-users@vger.kernel.org
Subject: Email Security upgrading process 
Date: 21 Aug 2024 20:57:23 +0200
Message-ID: <20240821205722.4809ED334E14E9BF@sdfgruop.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

