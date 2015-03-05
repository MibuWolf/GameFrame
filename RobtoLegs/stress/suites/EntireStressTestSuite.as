//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package suites
{
	import robotlegs.bender.extensions.ExtensionsStressTestSuite;
	import robotlegs.bender.framework.FrameworkStressTestSuite;

	[RunWith("org.flexunit.runners.Suite")]
	[Suite]
	public class EntireStressTestSuite
	{

		/*============================================================================*/
		/* Public Properties                                                          */
		/*============================================================================*/

		public var extensions:ExtensionsStressTestSuite;

		public var framework:FrameworkStressTestSuite;
	}
}
